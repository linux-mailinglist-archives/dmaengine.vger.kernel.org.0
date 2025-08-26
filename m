Return-Path: <dmaengine+bounces-6219-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3F3B3728A
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 20:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC1C04E260B
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 18:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23105371EBD;
	Tue, 26 Aug 2025 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AgVXpgcj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F1B371E9E
	for <dmaengine@vger.kernel.org>; Tue, 26 Aug 2025 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234144; cv=none; b=qsDZyFANbnrQ9su9DPuFV72M1CqTNx1g9/Y3R650QTHJg4EeX3+fHmo0oqLSUvRJAJdckDlC51xJeWsSah7xlFW4aIcX5ZED+GTxanzEV8L1mXOwYzUQdA6JsOG/3kIVqfQIPapiBE1ohmaijX0XRZMgYBnToVjPOklZNP/fC30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234144; c=relaxed/simple;
	bh=E/Ye7/SL7tqTx9oBx/tviBmGnvw5YMp+2zk7nWejWf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpFvyq2HCTNn9KhCS7EI94lrXV6vdODYruHiIqrLwI2yivyKcKHvXTCJNe83wi2FRk3FoUJMGdR6ltQx4U4C5PguGr9kBX1MhfQ+0SFYPVBuBREIJISlX9iWIIZAJBfwkb0g3VMoeMShOw3dITZUp0v4IQUXRxhd1LZCdTawlaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AgVXpgcj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24611734e50so26245ad.1
        for <dmaengine@vger.kernel.org>; Tue, 26 Aug 2025 11:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756234141; x=1756838941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/Ye7/SL7tqTx9oBx/tviBmGnvw5YMp+2zk7nWejWf0=;
        b=AgVXpgcjDr9q0cS0bj8JMWInMebRYXt+OlXrwg9uWZtxCDEGAAIHZ3Q2+foOHm7EtJ
         M1a1/P/1ZdmsTqvgB91Fw1oLEKJfkEpPxtdXyO1h+ZsMNoRasLukg83hO8hxEBl/vzgb
         blej+3tX1kv8vjoxm0eeYveDe1fVratZcb+0nZ3k+zAKqfH7DstQSzftAdjrLUY3b9lP
         VFLjfXViSByXPGHLsW5+jWUlRlaRzYxqpZOBet0a0sHAv33muLCeUj/m1cERrLdDvs2X
         qVaW2rEgwm+AmTJUnEPaJUqi+6dDEd0JieCGzRPCDS5B94usjZMauleUCipOGgMEJZTo
         LxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756234141; x=1756838941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/Ye7/SL7tqTx9oBx/tviBmGnvw5YMp+2zk7nWejWf0=;
        b=S+meimd3D5POIx+stvAUuCHVXmKxtyi4ryRw9J1dIcunMrTC6inDKHCfyljlgIwZmR
         h+ZjqZw3V7gqSCJj6k9pK2IP/Dn/3ya5QiUxY7GkiYXDesb276p7X8KUSzHntC7r2Pr7
         TY5XKewzU6sLrkrdoUUzkECOxxWbKwaiYfun2gaq5LgZZ5syq292jPmfZKQ9bwEzNXWY
         AQdwsjAnEy3SDDWD+4Kk9UPS8eBBgODkBHmIsnM7nfcVWDSdAC/2Gr0sUIIAa7FGVYGi
         AGHRWpqqF4fHjxiOvUqW0At1ODWLyUcXuAC5Pk60J/p3hIup1UNUh/2AlLzGTotDdAwF
         zuRA==
X-Forwarded-Encrypted: i=1; AJvYcCV4s+unbavs0IZDAbu6qT4LWsnssCwUCTGlKeSfYbvTf21oMNS5J47kqYV8eUlmYJjjZJqcNWPeIJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPzo1/wyj4Ar26JXrET/s3gMfiU+Z3VWlBY9ZM0lcXz0BcRpRm
	LZ8UimC5hXoHU/qNaP6/ZNqd9870oJnPoYdiPyV82uZ8P1jNum8ubn8nfm0rnTA0k4h4D1CL/5A
	NlaBhxZR1hP7u3mE+PDRKu2WkzaTfsRSKkXxzwDf2
X-Gm-Gg: ASbGncvZ6Yk74pEwxzp3ec3SOZgp0+2nZRFdwWkCpqcp9OAZ2KOaXVysxbzNjB8f6xJ
	s+CDbsH7qVewTySE+SxtL2/nfSx9fr/5aE2bslBt5vmd8chh0wvlENwn41k9g5ls4k47GtpUk7c
	TytRt33kEc9laWmtsZogCoKSBGTyaxvFKT0HakagAvA23gXkTXMWuBaQ4LDJwIFW42AdIB2tCSW
	l6730/twAeewO3v+CT9MDnB9oV2oQzwyK1wRlpfcWV4l7CVLr4gTKsqXV8I2lnn
X-Google-Smtp-Source: AGHT+IG+ollMBmiaOYcyGD4fK0EXbH34IwD2F+IqBBnZbD5S5EK8GUe1Cco16tj20beWZxJ5YP1hQInru/5q0vhDcUY=
X-Received: by 2002:a17:903:228c:b0:243:afef:cd88 with SMTP id
 d9443c01a7336-2486395f193mr4627105ad.11.1756234140425; Tue, 26 Aug 2025
 11:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755096883.git.robin.murphy@arm.com> <d6cda4e2999aba5794c8178f043c91068fa8080c.1755096883.git.robin.murphy@arm.com>
 <20250826130329.GX4067720@noisy.programming.kicks-ass.net> <6080e45d-032e-48c2-8efc-3d7e5734d705@arm.com>
In-Reply-To: <6080e45d-032e-48c2-8efc-3d7e5734d705@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 26 Aug 2025 11:48:48 -0700
X-Gm-Features: Ac12FXxL0fQGFTk6-3SCJz15Qd8Ums9V_bcQA6gIxaEwQacWk3scYfeQZZ7cYZQ
Message-ID: <CAP-5=fXF2x3hW4Sk+A362T-50cBbw6HVd7KY+QEUjFwT+JL37Q@mail.gmail.com>
Subject: Re: [PATCH 12/19] perf: Ignore event state for group validation
To: Robin Murphy <robin.murphy@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will@kernel.org, 
	mark.rutland@arm.com, acme@kernel.org, namhyung@kernel.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-fpga@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, coresight@lists.linaro.org, 
	iommu@lists.linux.dev, linux-amlogic@lists.infradead.org, 
	linux-cxl@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 8:32=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2025-08-26 2:03 pm, Peter Zijlstra wrote:
> > On Wed, Aug 13, 2025 at 06:01:04PM +0100, Robin Murphy wrote:
> >> It may have been different long ago, but today it seems wrong for thes=
e
> >> drivers to skip counting disabled sibling events in group validation,
> >> given that perf_event_enable() could make them schedulable again, and
> >> thus increase the effective size of the group later. Conversely, if a
> >> sibling event is truly dead then it stands to reason that the whole
> >> group is dead, so it's not worth going to any special effort to try to
> >> squeeze in a new event that's never going to run anyway. Thus, we can
> >> simply remove all these checks.
> >
> > So currently you can do sort of a manual event rotation inside an
> > over-sized group and have it work.
> >
> > I'm not sure if anybody actually does this, but its possible.
> >
> > Eg. on a PMU that supports only 4 counters, create a group of 5 and
> > periodically cycle which of the 5 events is off.

I'm not sure this is true, I thought this would fail in the
perf_event_open when adding the 5th event and there being insufficient
counters for the group. Not all PMUs validate a group will fit on the
counters, but I thought at least Intel's core PMU would validate and
not allow this. Fwiw, the metric code is reliant on this behavior as
by default all events are placed into a weak group:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/metricgroup.c?h=3Dperf-tools-next#n631
Weak groups are really just groups that when the perf_event_open fails
retry with the grouping removed. PMUs that don't fail the
perf_event_open are problematic as the reads just report "not counted"
and the metric doesn't work. Sometimes the PMU can't help it due to
errata. There are a bunch of workarounds for those cases carried in
the perf tool, but in general weak groups working is relied upon:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/pmu-events.h?h=3Dperf-tools-next#n16

Thanks,
Ian

> > So I'm not against changing this, but changing stuff like this always
> > makes me a little fearful -- it wouldn't be the first time that when it
> > finally trickles down to some 'enterprise' user in 5 years someone come=
s
> > and finally says, oh hey, you broke my shit :-(
>
> Eww, I see what you mean... and I guess that's probably lower-overhead
> than actually deleting and recreating the sibling event(s) each time,
> and potentially less bother then wrangling multiple groups for different
> combinations of subsets when one simply must still approximate a complex
> metric that requires more counters than the hardware offers.
>
> I'm also not keen to break anything that wasn't already somewhat broken,
> especially since this patch is only intended as cleanup, so either we
> could just drop it altogether, or perhaps I can wrap the existing
> behaviour in a helper that can at least document this assumption and
> discourage new drivers from copying it. Am I right that only
> PERF_EVENT_STATE_{OFF,ERROR} would matter for this, though, and my
> reasoning for state <=3D PERF_EVENT_STATE_EXIT should still stand? As for
> the fiddly discrepancy with enable_on_exec between arm_pmu and others
> I'm not really sure what to think...
>
> Thanks,
> Robin.

