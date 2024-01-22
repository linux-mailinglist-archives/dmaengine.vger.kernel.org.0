Return-Path: <dmaengine+bounces-773-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7634E835E3F
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 10:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E649C2830A6
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 09:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA4639ACC;
	Mon, 22 Jan 2024 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADJ1vyGp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D180B39ACA
	for <dmaengine@vger.kernel.org>; Mon, 22 Jan 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915942; cv=none; b=Em5tRLbymvXkdQojeGNCTPDGoJHpOonoQr5VaKITjtI3C8tCJSqJr0ry1sAogwbZUGJNb/cgV1ooeYJzoqW7eZuLIESFJ9XQErAQkqhccJL4kx7McHS71WUV5KfubXuCESR0g2UYsXdQxV8JPeyv0S4yzQRpNPg2gbBI5kwb3D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915942; c=relaxed/simple;
	bh=JHBv5VK8UhFkRYxEEnUJTT7E8VBGmqa85VH1B/8OBak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlptwwmEx3ljDriApfm9qhlPJP3uKcqkNBX9bRXLF2Lw5PHDwJFnVR/wHZEff9ZaDaUh6H9EIr/i40zv9LP640iDtmEqp+yVIIRLvD2bXii0l/vFQUATkWCDupekVF7v4NTpJIsETkVZAq16HyAhOh+hfGbgwX8JpbW96BfS6yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADJ1vyGp; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50ea9e189ebso2877510e87.3
        for <dmaengine@vger.kernel.org>; Mon, 22 Jan 2024 01:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705915939; x=1706520739; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qx1Z6PJPz1AbmQ1KsncjQOCAp/Ry++ha4WJKihgymDw=;
        b=ADJ1vyGpWEYvl6F3ylfMgziCE/0d101TtALfD4XOLZ+nwAEPtIU99yz98RNa73AlnC
         DW4SvpKVQDJR6EfCAuM8YltU3L0YUc0nPZGtAhwh3g1SyyblogDh+KstRPazfQO37siX
         t8xdKiOiuauDxM/U0mfdNXDPHOVvKdJH/ZXg13Rp6niQNsrGZ50VPQTN5TX5HQWZOBdW
         WGrc7aN97oDMUAWpYE0kfsvJpmoEvvH2m9nkNGv6ygLiM4ozVdu0aZ+jQPTtPl9tUoQQ
         R16t41DAVrZYBf+MAIWWcQJM1Epm+JjEY5PFN1XdB5C6yvzFCBtxt1jjHHuo1tlYTtPU
         Kiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705915939; x=1706520739;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qx1Z6PJPz1AbmQ1KsncjQOCAp/Ry++ha4WJKihgymDw=;
        b=rRAICkwq0Y7n4tZVGcKva6Tyw5eg8Sc/agmXWe6rUvut9sAI+9VamrHpdkWX2AaWgW
         3NzxnMSBNvfNPodjO1BPX3VC0XjMvG0myn+RJ533QSebM+UycIRVl59siuASZ1SV1V8J
         NkrNMXTt5ml9zov0SONKYcYtRWgkdAHnOsVFUTEUqvRDAUrsZzxtOEfATWSR/e6nP99k
         RH7XIKrDRQV+fGsoRrrgjHtgZzle6TQy4sH512unAU6pbS9eGvhR03nJZTuORnrw+55A
         d70eaJmb88jtOnnXud7hB/MXhTrA3mBuIdVmwigyD531j1JN2UQHkk5KFUoZdLeq9lVr
         Nl/g==
X-Gm-Message-State: AOJu0Yz4hmW5xvo7CoU5w1dzcMFZvRe3FGCsZ66YL9VqRDGCLsBENUtZ
	hPEb/RpMWxSj7jxNS4XJbAEE56t2UPJ9YHonnk+dc6aUw4H6remkvtp7/HOl
X-Google-Smtp-Source: AGHT+IFx0p51EMjqg9N/CU6LEdLQsSvDiFoxdd708pVl+t/OInrqhssF/cFBT8cK4ofzTUskCfSWWQ==
X-Received: by 2002:a05:6512:3f02:b0:50e:a219:e05d with SMTP id y2-20020a0565123f0200b0050ea219e05dmr1443160lfa.12.1705915938289;
        Mon, 22 Jan 2024 01:32:18 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id f12-20020a05651232cc00b0050f0dce126bsm1882672lfg.214.2024.01.22.01.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 01:32:17 -0800 (PST)
Date: Mon, 22 Jan 2024 12:32:16 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 3/3] dmaengine: dw-edma: increase size of 'name' in
 debugfs code
Message-ID: <acwdroop2av6sdfqca63dds7dyscauumypmrmooyrcquhy3jd3@5mf2utzdrlxh>
References: <20240119124944.152562-1-vkoul@kernel.org>
 <20240119124944.152562-3-vkoul@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240119124944.152562-3-vkoul@kernel.org>

Hi Vinod

On Fri, Jan 19, 2024 at 06:19:44PM +0530, Vinod Koul wrote:
> We seem to have hit warnings of 'output may be truncated' which is fixed
> by increasing the size of 'name'
> 
> drivers/dma/dw-edma/dw-hdma-v0-debugfs.c: In function ‘dw_hdma_v0_debugfs_on’:
> drivers/dma/dw-edma/dw-hdma-v0-debugfs.c:125:50: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Werror=format-truncation=]
>   125 |                 snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
>       |                                                  ^~
> 
> drivers/dma/dw-edma/dw-hdma-v0-debugfs.c: In function ‘dw_hdma_v0_debugfs_on’:
> drivers/dma/dw-edma/dw-hdma-v0-debugfs.c:142:50: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Werror=format-truncation=]
>   142 |                 snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
>       |                                                  ^~
> drivers/dma/dw-edma/dw-edma-v0-debugfs.c: In function ‘dw_edma_debugfs_regs_wr’:
> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:193:50: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Werror=format-truncation=]
>   193 |                 snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
>       |                                                  ^~
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Thanks for submitting the patch. I've got a similar one hanging out in
my local repo. I was going to submit it together with a few another
fixes, but then I had to switch my efforts to another task and
successfully forgot about this warning fix.

Please note the warning you stated above is false-positive in this
context since a name of the channel is printed to the string buffer in a
format like "channel:<int>", where "<int>" is the channel number and
which never supposed to be greater than eight. Anyway here is my tag:

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Here are three more tags which might be also reasonable to add:

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311030041.DznTeuS5-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202311030809.CjufIFaP-lkp@intel.com/

-Serge(y)

> ---
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 4 ++--
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> index 0745d9e7d259..406f169b09a7 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> @@ -176,7 +176,7 @@ dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
>  	};
>  	struct dentry *regs_dent, *ch_dent;
>  	int nr_entries, i;
> -	char name[16];
> +	char name[32];
>  
>  	regs_dent = debugfs_create_dir(WRITE_STR, dent);
>  
> @@ -239,7 +239,7 @@ static noinline_for_stack void dw_edma_debugfs_regs_rd(struct dw_edma *dw,
>  	};
>  	struct dentry *regs_dent, *ch_dent;
>  	int nr_entries, i;
> -	char name[16];
> +	char name[32];
>  
>  	regs_dent = debugfs_create_dir(READ_STR, dent);
>  
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> index 520c81978b08..dcdc57fe976c 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> @@ -116,7 +116,7 @@ static void dw_hdma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
>  static void dw_hdma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
>  {
>  	struct dentry *regs_dent, *ch_dent;
> -	char name[16];
> +	char name[32];
>  	int i;
>  
>  	regs_dent = debugfs_create_dir(WRITE_STR, dent);
> @@ -133,7 +133,7 @@ static void dw_hdma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
>  static void dw_hdma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
>  {
>  	struct dentry *regs_dent, *ch_dent;
> -	char name[16];
> +	char name[32];
>  	int i;
>  
>  	regs_dent = debugfs_create_dir(READ_STR, dent);
> -- 
> 2.43.0
> 
> 

