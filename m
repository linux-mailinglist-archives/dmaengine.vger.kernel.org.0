Return-Path: <dmaengine+bounces-4750-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDF6A61933
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 19:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D0819C5132
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A1C1624FE;
	Fri, 14 Mar 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDxKZ/iI"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055BD14A0A3
	for <dmaengine@vger.kernel.org>; Fri, 14 Mar 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741976201; cv=none; b=a17gDYdvpG84rQItWsUhiOUCXIt6P8gsfBGKKLAlz7fn4gTLLDIIUQ6svzDfZvaBs9DO5hkTWjjmwOeWIPNEB6Jtij1N4lmhxtspx68lnJvx0IfJPwTy8yjxGbFD1GTCs8deUibDqRKGC/LnbHwKI/LJF9s92XKGBMOV9W6LzHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741976201; c=relaxed/simple;
	bh=JIIEeajvuX4SKu4ze9WWEf4wgmdOElaYwbljNkRGxt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAvIE1BrsAiIWGB2mEFvPglTiQgLsNm0KmTw+bEfTZ14OWurtqI5vMElN0SlW/8cnru4F9trvC1HJAz/niYPDA5eNjPo1gfEETW1272x4Lu1xDnTMi+WhxFxSF5XGq9y9FR1sidFrU0yd3S4euuyCDjRxFQG0pq4RQGkDX95shY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDxKZ/iI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741976199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HTjOvmcOAAKCYjswPrcDxk++V2FzH3abycj3cNoEfgM=;
	b=hDxKZ/iIIjzn4Fz8SEOPVQBm336uvgLVMzJK9WucHiQhvvlmgP2R9UZNt9AWRJfcJf8/8Y
	4uuuqstxZTF+mISsN69GXVuDroG7g2VLMQ1BWCvNqv7a4bwVeyo9ebISvgMDX4c7sC0KqB
	xTOnHuYbuK/R0+xURcqxQUpRRpLZr8Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-NGjDVAdZNQGdHBbElQeexQ-1; Fri, 14 Mar 2025 14:16:35 -0400
X-MC-Unique: NGjDVAdZNQGdHBbElQeexQ-1
X-Mimecast-MFC-AGG-ID: NGjDVAdZNQGdHBbElQeexQ_1741976195
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-47689dc0f6dso45168811cf.3
        for <dmaengine@vger.kernel.org>; Fri, 14 Mar 2025 11:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741976195; x=1742580995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTjOvmcOAAKCYjswPrcDxk++V2FzH3abycj3cNoEfgM=;
        b=SQM5W/HksgTadFNPBvdgFD3RHj02DwWhaXVhx7uLJE7xvdiZzc/W9XV3sBwU9XK7p6
         TPBTr7p82Mydi7b/WhIY/SupSYQCmlfMM7KkKib6Wzb+jtfTaC0A0czvykhL5xic0CeQ
         L6bnCDXoUSA2LZZHT+VQLmvAckoYkvaA/JbRHvu6jCbqZspe/pWND16uwjgRgkZxTBVl
         RvUo8xcVGlS1p/q6KK623oh7wzQO7Z2CTl2ecSfmG1dECJTfi+YtSMemOlszcQeh3SPH
         EN8txUATIihIECPxc8hb155dRBnO+EcyLGyZQM74IgvRjwXZdCJfZjKjWCtBlmi7UNtP
         2VSA==
X-Forwarded-Encrypted: i=1; AJvYcCW/AQcf62X/cTip0qS80Uw04/hXxBI9SOY5qQXQTYzGq/H5l211ZKT8Lv5VNHrBjjFTPfEQ8UFztjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Uxzo7BGQN90CsGfeG5n6IM2EIJDquVrRhinEQ87FkSI69Nuh
	y2C4eLpi61fOddrKrO+xKArUfzGfLGuu6akwoqzhnq3FYVUvCUKs+BN/uxOQC0/zndZmp0Eg4dO
	pdb6zbvR9pYX/tYICfZdaRIdz4qs1n9CFgGRAimbf1EWM36p7AdrltYm3MXahz8gKjg==
X-Gm-Gg: ASbGncu4it7MElfM73Gz1llmHSB7blJrOS6bT49tvyQujXyBBh/fKk/0B5WFV/rKjGy
	vYOjSr1xgTnFQqWd8ZuCs6qgZ1xJPr3Ggyc5gG2EkCVofgYGoI6DD/dILiR08O4OMyK029JUSbJ
	ExsHmhMEBOFpkOth4KKgoJ3JMzIHVkCVgUrEPFs+kusmmd4He2qzaFJ4B4/umIS91LEUUpOR8jM
	YcVU1dPb1E+ehEgfop88rGmfQNtsC7dwNhP5hob5/KHZ9vMRHay97SJHuOamU8DCtkIbUnWqMBz
	8mJl8CFbnE1ibs9WwEp69ZKccVceR98e9NUQns42ASpJ
X-Received: by 2002:ac8:5886:0:b0:476:9ac6:2f6c with SMTP id d75a77b69052e-476c814a295mr55333731cf.18.1741976195310;
        Fri, 14 Mar 2025 11:16:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrohz+YGdkRe5TiDggSmUAnK8qP7UUTQjHYOhGAwuRR35nKZcXbAUNKhCarFvYMM05exlUxw==
X-Received: by 2002:ac8:5886:0:b0:476:9ac6:2f6c with SMTP id d75a77b69052e-476c814a295mr55333491cf.18.1741976195008;
        Fri, 14 Mar 2025 11:16:35 -0700 (PDT)
Received: from localhost (ip70-163-223-251.ph.ph.cox.net. [70.163.223.251])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb63ac51sm26204941cf.27.2025.03.14.11.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 11:16:34 -0700 (PDT)
Date: Fri, 14 Mar 2025 11:16:32 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	dma <dmaengine@vger.kernel.org>
Subject: Re: [GIT PULL]: Dmaengine subsystem fixes for v6.14
Message-ID: <3s2wvuofr53ly6bawc4cw7qgebru3usugc2oqlcpkxsgjtxtuw@pegt4pcqtefu>
References: <Z8SVslyQKIe41xET@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8SVslyQKIe41xET@vaman>

On Sun, Mar 02, 2025 at 11:00:26PM +0530, Vinod Koul wrote:
> Hello Linus,
> 
> Please pull to receive two fixes for tegra adma driver and revert of
> one qcom patch causing regressions.
> 
> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:
> 
>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.14
> 
> for you to fetch changes up to e521f516716de7895acd1b5b7fac788214a390b9:
> 
>   dmaengine: Revert "dmaengine: qcom: bam_dma: Avoid writing unavailable register" (2025-02-27 13:29:15 +0530)
> 
> ----------------------------------------------------------------
> dmaengine fixes for v6.14
> 
> Driver fixes for:
>  - tegra210 adma div_u64 divison and max page fixes
>  - Qualcomm Revert of unavailable register workaround which is causing
>    regression, fixes have been proposed but still gaps are present so revert
>    this for now
> 
> ----------------------------------------------------------------
> Caleb Connolly (1):
>       dmaengine: Revert "dmaengine: qcom: bam_dma: Avoid writing unavailable register"
> 
> Mohan Kumar D (2):
>       dmaengine: tegra210-adma: Use div_u64 for 64 bit division
>       dmaengine: tegra210-adma: check for adma max page
> 
>  drivers/dma/qcom/bam_dma.c  | 24 ++++++++----------------
>  drivers/dma/tegra210-adma.c | 20 ++++++++++++++++----
>  2 files changed, 24 insertions(+), 20 deletions(-)
> 
> -- 
> ~Vinod

Hi Vinod and Linus,

Did the merge conflict resolve correctly between

d440148418f4 ("tegra210-adma: fix 32-bit x86 build")

and

76ed9b7d177e ("dmaengine: tegra210-adma: check for adma max page")
17987453a9d9 ("dmaengine: tegra210-adma: Use div_u64 for 64 bit division")


Looking at the end result it added the bits below from 76ed9b7d177e on
top of d440148418f4, but the code where it makes use of max_page was
dropped.

Regards,
Jerry


diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 5c6a5b358987..ce80ac4b1a1b 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -83,7 +83,9 @@ struct tegra_adma;
  * @nr_channels: Number of DMA channels available.
  * @ch_fifo_size_mask: Mask for FIFO size field.
  * @sreq_index_offset: Slave channel index offset.
+ * @max_page: Maximum ADMA Channel Page.
  * @has_outstanding_reqs: If DMA channel can have outstanding requests.
+ * @set_global_pg_config: Global page programming.
  */
 struct tegra_adma_chip_data {
        unsigned int (*adma_get_burst_config)(unsigned int burst_size);
@@ -99,6 +101,7 @@ struct tegra_adma_chip_data {
        unsigned int nr_channels;
        unsigned int ch_fifo_size_mask;
        unsigned int sreq_index_offset;
+       unsigned int max_page;
        bool has_outstanding_reqs;
        void (*set_global_pg_config)(struct tegra_adma *tdma);
 };
@@ -854,6 +857,7 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
        .nr_channels            = 22,
        .ch_fifo_size_mask      = 0xf,
        .sreq_index_offset      = 2,
+       .max_page               = 0,
        .has_outstanding_reqs   = false,
        .set_global_pg_config   = NULL,
 };
@@ -871,6 +875,7 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
        .nr_channels            = 32,
        .ch_fifo_size_mask      = 0x1f,
        .sreq_index_offset      = 4,
+       .max_page               = 4,
        .has_outstanding_reqs   = true,
        .set_global_pg_config   = tegra186_adma_global_page_config,
 };


