"use client";

import { useEffect, useState } from "react";
import { FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { UseFormReturn } from "react-hook-form";
import { SubmissionWithTerseInput } from "@/lib/validation/submission";
import { getBiWeekRange, getCurrentBiWeek } from "@/lib/date-utils";
import { format } from "date-fns";

interface BiWeekSelectorProps {
  form: UseFormReturn<SubmissionWithTerseInput>;
  name: "weekOf";
}

export function WeekSelector({ form, name }: BiWeekSelectorProps) {
  const [biWeekOptions, setBiWeekOptions] = useState<{ value: string; label: string; range: string }[]>([]);

  useEffect(() => {
    const currentBiWeek = getCurrentBiWeek();
    const currentYear = new Date().getFullYear();

    const options = [];
    // Current bi-weekly period and previous period only
    for (let biWeek = currentBiWeek; biWeek >= Math.max(1, currentBiWeek - 1); biWeek--) {
      const { start, end } = getBiWeekRange(biWeek, currentYear);
      const periodDate = new Date(start);
      const value = periodDate.toISOString();
      const label = `Period ${biWeek}, ${currentYear}`;
      const range = `${format(start, "MMM d")} - ${format(end, "MMM d, yyyy")}`;
      options.push({ value, label, range });
    }
    setBiWeekOptions(options);
  }, []);

  const selectedValue = form.watch(name);
  const selectedPeriod = biWeekOptions.find(opt => opt.value === selectedValue?.toISOString?.());

  return (
    <FormField
      control={form.control}
      name={name}
      render={({ field }) => (
        <FormItem>
          <FormLabel>Bi-Weekly Period</FormLabel>
          <Select
            onValueChange={(value) => {
              field.onChange(new Date(value));
            }}
            value={field.value ? new Date(field.value).toISOString() : undefined}
          >
            <FormControl>
              <SelectTrigger>
                <SelectValue placeholder="Select a bi-weekly period" />
              </SelectTrigger>
            </FormControl>
            <SelectContent>
              {biWeekOptions.map((option) => (
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
