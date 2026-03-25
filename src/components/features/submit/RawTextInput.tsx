"use client";

import { FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Textarea } from "@/components/ui/textarea";
import { UseFormReturn } from "react-hook-form";
import { SubmissionWithTerseInput } from "@/lib/validation/submission";
import { cn } from "@/lib/utils";

interface RawTextInputProps {
  form: UseFormReturn<SubmissionWithTerseInput>;
  name: "rawText";
}

const MIN_CHARS = 10;
const MAX_CHARS = 5000;
const WARNING_THRESHOLD = 4000;
const DANGER_THRESHOLD = 4800;

export function RawTextInput({ form, name }: RawTextInputProps) {
  const value = form.watch(name) || "";
  const charCount = value.length;
  const isValid = charCount >= MIN_CHARS && charCount <= MAX_CHARS;
  const isWarning = charCount >= WARNING_THRESHOLD && charCount < DANGER_THRESHOLD;
  const isDanger = charCount >= DANGER_THRESHOLD;

  return (
    <FormField
      control={form.control}
      name={name}
      render={({ field }) => (
        <FormItem>
          <FormLabel>Bi-Weekly Activity Report</FormLabel>
          <FormControl>
            <Textarea
              {...field}
              placeholder={`Bi-weekly period of January 15-26, 2024

This bi-weekly period I worked on the following activities:
- Completed data analysis for Q4 emissions report
- Attended stakeholder meeting on Tuesday
- Reviewed 15 permit applications

Next period plans:
- Begin writing final report
- Coordinate with regional office`}
              className="min-h-[300px] resize-y"
            />
          </FormControl>
          <div className="flex justify-between items-center">
            <p className="text-sm text-muted-foreground">
              Minimum {MIN_CHARS} characters required
            </p>
            <p
              className={cn(
                "text-sm",
                isDanger && "text-red-500 font-medium",
                isWarning && "text-yellow-600",
                isValid && !isWarning && "text-green-600"
              )}
            >
              {charCount} / {MAX_CHARS} characters
            </p>
          </div>
          {charCount < MIN_CHARS && charCount > 0 && (
            <p className="text-sm text-red-500">
              Please enter at least {MIN_CHARS} characters
            </p>
          )}
          <FormMessage />
        </FormItem>
      )}
    />
  );
}
