import { Metadata } from "next";
import { notFound, redirect } from "next/navigation";
import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { getPendingSubmissions } from "@/app/actions/review";
import ReviewDetailClient from "@/components/features/review/ReviewDetailClient";

interface ReviewDetailPageProps {
  params: { id: string };
}

export async function generateMetadata({ params }: ReviewDetailPageProps): Promise<Metadata> {
  return {
    title: "Review Submission",
    description: "Review and edit WAR submission",
  };
}

export default async function ReviewDetailPage({ params }: ReviewDetailPageProps) {
  // Check authentication
  const session = await auth();
  if (!session?.user?.id) {
    redirect("/login");
  }

  // Check permissions (AGGREGATOR+)
  const hasPermission = await hasMinimumRoleLevel("AGGREGATOR");
  if (!hasPermission) {
    redirect("/unauthorized");
  }

  // Fetch submission with user info
  const submission = await prisma.submission.findFirst({
    where: {
      id: params.id,
      deletedAt: null,
      status: { in: ["SUBMITTED", "IN_REVIEW"] },
    },
    include: {
      user: {
        select: {
          id: true,
          name: true,
          email: true,
        },
      },
      reviews: {
        orderBy: { createdAt: "desc" },
        take: 1,
      },
    },
  });

  if (!submission) {
    notFound();
  }

  // Get queue info for navigation
  const queueResult = await getPendingSubmissions();
  let nextId: string | undefined;
  let prevId: string | undefined;
  let currentPosition = 1;
  let queueSize = 1;

  if (queueResult.success) {
    const queue = queueResult.submissions;
    queueSize = queue.length;
    const currentIndex = queue.findIndex((s) => s.id === params.id);
    
    if (currentIndex !== -1) {
      currentPosition = currentIndex + 1;
      nextId = queue[currentIndex + 1]?.id;
      prevId = queue[currentIndex - 1]?.id;
    }
  }

  return (
    <ReviewDetailClient
      submission={submission}
      nextId={nextId}
      prevId={prevId}
      queueSize={queueSize}
      currentPosition={currentPosition}
    />
  );
}
