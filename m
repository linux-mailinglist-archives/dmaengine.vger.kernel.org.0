Return-Path: <dmaengine+bounces-6207-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AABB36173
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 15:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A4047B978F
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 13:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F9C32144B;
	Tue, 26 Aug 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="etY5PLFf"
X-Original-To: dmaengine@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B861654654;
	Tue, 26 Aug 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213727; cv=none; b=J1/t/uUAKsqKg920HuccGxDVv0a2ej5Ptu7vXBMMxeZ27lDER4/kK3KpbeyINRoFWgU70Rzcgbk6KSeHUcdFG4dp4ZfK/EyXfjRiFkumtYOEYye8q4gn3jZDoZ/612IvZF7ccT5ChCyUqryIHCNsnBF8NcbBFXgKvueNaHb/ugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213727; c=relaxed/simple;
	bh=JHZTLFlxAYI1wokhjuCEuruyUylGu43DM7IKjkNYSic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYrgTdBOMnong+3oTGZmzyETw1VzNyGOk2Cu3BzXxaM2tPyqtb7O7isEk0pZFKpfchJ3gDxkyTrgalgIoKjUnxF/oasQ5EUwHsxX7tkMPYaEY+J9xlQ5Ft052yH+4bmE2OpLAIt446RQrC4Tzd2kD2cOPKQ+iY6sVlvmE0lUk1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=etY5PLFf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JHZTLFlxAYI1wokhjuCEuruyUylGu43DM7IKjkNYSic=; b=etY5PLFfHvVwRjOXszye/DGGB6
	EeDfwhUfPBBHElGIuEt4CBRy1AldhAFBccZnj543K6AV4Xvqq6pcdNIfqcf1J9sqxP9GTv1Rld421
	0AuJKLh2CRWDkm+Ul9/DFHMDYluLA3AIkv78pFeyA09fvuZwxu6ukwM8cR1N29k6qKImuFZmW3MMM
	qCVOi9ccAynQbDiNrFS78BcReEN5xdvzHPhO4NkOVApB1RYQ/p8auBap2lsOA66RFcIqiEM+p/Jrp
	EIJVtCqUjQE/N3Tepz7e+3E78hAlvb2elxzZDQC0yDBfD4BGP9yDnTXc67Vd2CW73P1jADDmWRbp0
	QXd2jvjA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqtPb-00000002DYZ-2cEd;
	Tue, 26 Aug 2025 13:08:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A98B6300323; Tue, 26 Aug 2025 15:08:30 +0200 (CEST)
Date: Tue, 26 Aug 2025 15:08:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: mingo@redhat.com, will@kernel.org, mark.rutland@arm.com,
	acme@kernel.org, namhyung@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
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
Subject: Re: [PATCH 17/19] perf: Retire PERF_PMU_CAP_NO_INTERRUPT
Message-ID: <20250826130830.GZ4067720@noisy.programming.kicks-ass.net>
References: <cover.1755096883.git.robin.murphy@arm.com>
 <32bf39943eef7c7f516d814d749cdbe322eec204.1755096883.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32bf39943eef7c7f516d814d749cdbe322eec204.1755096883.git.robin.murphy@arm.com>

On Wed, Aug 13, 2025 at 06:01:09PM +0100, Robin Murphy wrote:
> Now that we have a well-defined cap for sampling support, clean up the
> remains of the mildly unintuitive and inconsistently-applied
> PERF_PMU_CAP_NO_INTERRUPT. Not to mention the obvious redundancy of
> some of these drivers still checking for sampling in event_init too.

Ah, clearly I should've read the next patch... n/m.

