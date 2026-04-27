"use client";

import { useEffect, useState } from "react";
import { FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { UseFormReturn } from "react-hook-form";
import { SubmissionWithTerseInput } from "@/lib/validation/submission";
import { getCurrentWeek, getWeekRange } from "@/lib/date-utils";
import { format } from "date-fns";
import { HintTooltip } from "./FormGuidance";

interface WeekSelectorProps {
  form: UseFormReturn<SubmissionWithTerseInput>;
  name: "weekOf";
}

export function WeekSelector({ form, name }: WeekSelectorProps) {
  const [weekOptions, setWeekOptions] = useState<{ value: string; label: string; range: string }[]>([]);

  useEffect(() => {
    const currentWeek = getCurrentWeek();
    const currentYear = new Date().getFullYear();

    const options = [];
    // Current week and previous week only
    for (let week = currentWeek; week >= Math.max(1, currentWeek - 1); week--) {
      const { start, end } = getWeekRange(week, currentYear);
      const weekDate = new Date(start);
      const value = weekDate.toISOString();
      const label = `Week ${week}, ${currentYear}`;
      const range = `${format(start, "MMM d")} - ${format(end, "MMM d, yyyy")}`;
      options.push({ value, label, range });
    }
    setWeekOptions(options);
  }, []);

  const selectedValue = form.watch(name);
  const selectedPeriod = weekOptions.find((opt) => opt.value === selectedValue?.toISOString?.());

  return (
    <FormField
      control={form.control}
      name={name}
      render={({ field }) => (
        <FormItem data-tour="war-period">
          <FormLabel>
            <span className="inline-flex items-center gap-1.5">
              Reporting Week
              <HintTooltip content="Pick the current reporting week or, if needed, the previous one. The date range below confirms exactly what will be submitted." />
            </span>
          </FormLabel>
          <Select
            onValueChange={(value) => {
              field.onChange(new Date(value));
            }}
            value={field.value ? new Date(field.value).toISOString() : undefined}
          >
            <FormControl>
              <SelectTrigger>
                <SelectValue placeholder="Select a reporting week" />
              </SelectTrigger>
            </FormControl>
            <SelectContent>
              {weekOptions.map((option) => (
                <SelectItem key={option.value} value={option.value}>
                  <div className="flex flex-col">
                    <span>{option.label}</span>
                    <span className="text-xs text-muted-foreground">{option.range}</span>
                  </div>
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
          {selectedPeriod && (
            <p className="text-sm text-muted-foreground mt-1">
              {selectedPeriod.range}
            </p>
          )}
          <FormMessage />
        </FormItem>
      )}
    />
  );
}
