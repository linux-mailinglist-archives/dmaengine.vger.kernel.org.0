Return-Path: <dmaengine+bounces-4088-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD14A05944
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jan 2025 12:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C965A18822D2
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jan 2025 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A74A1F3D53;
	Wed,  8 Jan 2025 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptYYEETA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8F019D06A;
	Wed,  8 Jan 2025 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736334623; cv=none; b=Z8B817GbiXy25RuMLkT4YYil3xvW/0d+XKCeOzkVx7fQ0SdaoahdHa3D2Jp+blhumblj9/nxPthW+zdmSQLq8fOOqpmXE1qiDvk6NDQqyIrMjPUayKJfuMjBYtaHcsFlRoRDwGrDKLA6s57nOpFn+tVqm8Vj2BWNj7gzTe15sYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736334623; c=relaxed/simple;
	bh=BQVTkGBa3sFSGo2a1+LUlQ3fXejyr9MIERqpWM0YmaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwmwfzXevn8ANE56RwfrllGC4aWcHUwcM3IXTc/3OPTGedSoirnIGQFqhinbNzw617j5cwVaa8vgGUzHYGEeU7EEWLt3Pk2SWAwIEckIcJzCY+Qe5sJGNy8dMA7VWHXYGi5Tze6VwAmC2dsbrkGgMtFTm4Z3fV3UrEoHbyqNWiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptYYEETA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3A7C4CEDD;
	Wed,  8 Jan 2025 11:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736334622;
	bh=BQVTkGBa3sFSGo2a1+LUlQ3fXejyr9MIERqpWM0YmaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ptYYEETAqxzN7ofeUU9dDrqp5qszrb/iDH+V1i8yMqTiHXyVofhFBJfzn/tEjiLZP
	 gDcBRFbZQPLRI31l/ZVPTqKMidigdDvdWxYRanIqP07rAz5beZI2VV1f+t06GUWCRf
	 CBUR5nerZEQ6L1uSZCurBOJ0LosWLMJzbqRVBOwSDO5+8CprDc13vwVBfmZkVZLTnv
	 RoQ+g2y+q3jdZCZWfW3orUlqNoJ16CVEPSpaUf/94YpnEDNcHmzOa2bRr5RGbMct1/
	 j/a8ayJ26CPHz1HIx3ujQQRxeQFt7ycRNVJAEUgPT5QiBo2zCLdkpJJ0hMiS9Trkw9
	 JD4xBKox4KRyQ==
Date: Wed, 8 Jan 2025 16:40:19 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, quic_mmanikan@quicinc.com,
	quic_srichara@quicinc.com, quic_varada@quicinc.com,
	robin.murphy@arm.com, u.kleine-koenig@baylibre.com,
	martin.petersen@oracle.com, fenghua.yu@intel.com,
	av2082000@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dmaengine: qcom: bam_dma: Avoid writing unavailable
 register
Message-ID: <Z35dG7J8BLzeoT3B@vaman>
References: <20241220094203.3510335-1-quic_mdalam@quicinc.com>
 <9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org>

On 07-01-25, 23:30, Georgi Djakov wrote:
> On 20.12.24 11:42, Md Sadre Alam wrote:
> > Avoid writing unavailable register in BAM-Lite mode.
> > BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
> > mode. Its only available in BAM-NDP mode. So only write
> > this register for clients who is using BAM-NDP.
> > 
> > Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> > ---
> 
> My Dragonboard db845c fails to boot on recent linux-next releases and
> git bisect points to this patch. It boots again when it's reverted.

Should we revert?

> 
> [..]
> 
> >   	bchan->reconfigure = 0;
> > @@ -1192,10 +1199,11 @@ static int bam_init(struct bam_device *bdev)
> >   	u32 val;
> >   	/* read revision and configuration information */
> > -	if (!bdev->num_ees) {
> > -		val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
> > +	val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
> > +	if (!bdev->num_ees)
> >   		bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
> > -	}
> > +
> > +	bdev->bam_revision = val & REVISION_MASK;
> 
> The problem seems to occur when we try to read the revision for the
> slimbus bam instance at 0x17184000 (which has "qcom,num-ees = <2>;").
> 
> Thanks,
> Georgi

-- 
~Vinod

