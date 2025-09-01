Return-Path: <dmaengine+bounces-6304-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A00AFB3E01C
	for <lists+dmaengine@lfdr.de>; Mon,  1 Sep 2025 12:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA2718907C5
	for <lists+dmaengine@lfdr.de>; Mon,  1 Sep 2025 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D23530F549;
	Mon,  1 Sep 2025 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y2CXlHCp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DFF30F541
	for <dmaengine@vger.kernel.org>; Mon,  1 Sep 2025 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722429; cv=none; b=cwY9+Xg/X4l/d0E5cfWWRQiemu6Xl9b/HWQtfWI4FC/gWctmiIFRBQOWNOZBIji8YwA/ObFAQtRGUvN0rx6dmIZ8fnhl4Z97NuZFqCE4n5ggGNVF+jhrdfBSOX4nYrJQbhw3WPeFh4X4IbBI6LQweuNYivQprq0NGDVJ5SGvyVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722429; c=relaxed/simple;
	bh=6h/YI/Py/XlG4xBbZJ7thzV4uG9Z0BsZDM3FqQjDBdE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BGXQ1jUOkqrJyC12C3u4f1zJohYOU8X/ym2oTOP/mZRzeytNgVy75DCqsR49m/XR3cNVaxcz0nldCuRmnaURHv6bJx3MjHBmV/ZqAGHETJ2/V30lisCdkisgbtiaGom+NNPD12DkZVRav5uJksGKCdEfe2BxLHMD8zpbx7SeUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y2CXlHCp; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3d1bf79d6eeso1227638f8f.2
        for <dmaengine@vger.kernel.org>; Mon, 01 Sep 2025 03:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756722425; x=1757327225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3wMAXUg6TcQMtXg5Lgxugiws7d3wfWBJLDrvyAva+k=;
        b=y2CXlHCpkTmxqjhja4moihSjlo/kiMrxjrx/pE0Dzwsj6FFmywwrJt+Sg3cVBNbzWs
         XfJawbLzXNwadZJbYP07CvrzT8Sk1QhMr6CZlZhNB7IZ32wlTWvsz4eIiDBWNjvRUDCc
         Vdprl29gC9JFnJWjruuNGZjZzPHWlBjQxxxU2Rqw9D/5QJGORo+vTbs/B433aCKHzxl+
         r9NlZ3eIp1xhf3dlw9KiJ+WXlgW6ftPO+oyR85tY0kIszj11MuDHgi9a28L5tA71qMW8
         3f59sLUhxUbNtn/s5CXGk8cKbDocNWZnnB0rCLLJmD15pDDkJnTr79gfTnjAdCXQ5q9f
         aPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756722425; x=1757327225;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3wMAXUg6TcQMtXg5Lgxugiws7d3wfWBJLDrvyAva+k=;
        b=TNIbGuuFAYo5mgJuRm8jkSIq9u9Aa/L3uY3DbQRFxTg6XO3jDz/O7+i0OoMaf9ajf1
         1BO7x4pykE5tWa7WBRPoYBXkXcxvt/L6YXhUwr3Nh4zZmDPIRcJhRLK0HIQtA1toQAQ3
         7m5FVL6TttiphZcNZye26x42ctjyZcO/F5ztFdi8M6ajmp5KoQFf1fMBRN+SLdrN1iiw
         4TrTi77nqAzjlqQErTpHY1lV5NVYJC1D+ziv5DkemmYse7jEk1Gq9MvwWf7lOs73HU7F
         ZODGARrBNZnDJQbqt/PkMj3uXX6Pb2LX0cESk+5YX6F+9mRcCKKZX39wgTzlT3dcmy2W
         BTCA==
X-Forwarded-Encrypted: i=1; AJvYcCXuNq9jk0SI98bzCy4fwiWTpHg2yMvHCKkGWkXRdYBEt5m834qjgTjiPN9lTmfN1VTtwzKgt7/B11c=@vger.kernel.org
X-Gm-Message-State: AOJu0YygiNRTsgq0CfDFGMk0qOcDBiJ+ZCVBQeF78nGNTynf6CMY2DPC
	cVFOaTfhKd/9xVp+7EoeOEKpd0PLp8cDlE0hOwTJpQ1IK9dFiLsuJz+d8YxvcMQxODA=
X-Gm-Gg: ASbGncuaau1sM7PcoGGVrCfzPMCHSUHDi/lhZql67kuSWevrQniSftK/nCtsORVzWf4
	P5LMXjORHVDH2Jl5OfV8jykOWNZKfoFYQQe/iunWOwV0WofHq0GpEJ8uMSJ34Kx8dzIbFXkb+3k
	6sbVW16LraUxNzyiy4byEMtf7aRRkZVmSxnOE4rBbQx8LSrYMNsXVPDbF6/GImi/OFQx7ReaI5o
	WSewfa9fOy4JTcYt02y8yGZemSRxKhvHyxgcUPFE/21ens5/H7SnV/70e6f9/EjHsn/1bR4J9Sm
	B+0RgXpNoaCjK9z6w9WpMP15Dy0wTApc+gWZU1R9GrAA+PshWXeKh2O3nDQASkfl/P8KJCKJeSf
	ltNcEucraCYyvxKkgLTTg16mSZmJQ2PzpzISFcA==
X-Google-Smtp-Source: AGHT+IE2RqWOouUNKF0LuMwYDv8VNEg+V4AVmzf6zsck7npghoz21h/jWKBn3nN0q+raGVTCFFwHxQ==
X-Received: by 2002:a05:6000:2510:b0:3d7:7def:8435 with SMTP id ffacd0b85a97d-3d77def8d9dmr1055874f8f.18.1756722425227;
        Mon, 01 Sep 2025 03:27:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf34493b8csm14441165f8f.59.2025.09.01.03.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 03:27:04 -0700 (PDT)
Date: Mon, 1 Sep 2025 13:27:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Jisheng Zhang <jszhang@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/14] dmaengine: dma350: Alloc command[] from dma pool
Message-ID: <202508291556.kjNumYgR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823154009.25992-11-jszhang@kernel.org>

Hi Jisheng,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jisheng-Zhang/dmaengine-dma350-Fix-CH_CTRL_USESRCTRIGIN-definition/20250824-000425
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20250823154009.25992-11-jszhang%40kernel.org
patch subject: [PATCH 10/14] dmaengine: dma350: Alloc command[] from dma pool
config: arm-randconfig-r073-20250829 (https://download.01.org/0day-ci/archive/20250829/202508291556.kjNumYgR-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.4.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508291556.kjNumYgR-lkp@intel.com/

smatch warnings:
drivers/dma/arm-dma350.c:387 d350_get_residue() error: uninitialized symbol 'sgcur'.

vim +/sgcur +387 drivers/dma/arm-dma350.c

5d099706449d54 Robin Murphy  2025-03-12  360  static u32 d350_get_residue(struct d350_chan *dch)
5d099706449d54 Robin Murphy  2025-03-12  361  {
eae79fde2ff50c Jisheng Zhang 2025-08-23  362  	u32 res, xsize, xsizehi, linkaddr, linkaddrhi, hi_new;
eae79fde2ff50c Jisheng Zhang 2025-08-23  363  	int i, sgcur, retries = 3; /* 1st time unlucky, 2nd improbable, 3rd just broken */
eae79fde2ff50c Jisheng Zhang 2025-08-23  364  	struct d350_desc *desc = dch->desc;
5d099706449d54 Robin Murphy  2025-03-12  365  
5d099706449d54 Robin Murphy  2025-03-12  366  	hi_new = readl_relaxed(dch->base + CH_XSIZEHI);
5d099706449d54 Robin Murphy  2025-03-12  367  	do {
5d099706449d54 Robin Murphy  2025-03-12  368  		xsizehi = hi_new;
5d099706449d54 Robin Murphy  2025-03-12  369  		xsize = readl_relaxed(dch->base + CH_XSIZE);
5d099706449d54 Robin Murphy  2025-03-12  370  		hi_new = readl_relaxed(dch->base + CH_XSIZEHI);
5d099706449d54 Robin Murphy  2025-03-12  371  	} while (xsizehi != hi_new && --retries);
5d099706449d54 Robin Murphy  2025-03-12  372  
eae79fde2ff50c Jisheng Zhang 2025-08-23  373  	hi_new = readl_relaxed(dch->base + CH_LINKADDRHI);
eae79fde2ff50c Jisheng Zhang 2025-08-23  374  	do {
eae79fde2ff50c Jisheng Zhang 2025-08-23  375  		linkaddrhi = hi_new;
eae79fde2ff50c Jisheng Zhang 2025-08-23  376  		linkaddr = readl_relaxed(dch->base + CH_LINKADDR);
eae79fde2ff50c Jisheng Zhang 2025-08-23  377  		hi_new = readl_relaxed(dch->base + CH_LINKADDRHI);
eae79fde2ff50c Jisheng Zhang 2025-08-23  378  	} while (linkaddrhi != hi_new && --retries);
eae79fde2ff50c Jisheng Zhang 2025-08-23  379  
eae79fde2ff50c Jisheng Zhang 2025-08-23  380  	for (i = 0; i < desc->sglen; i++) {
eae79fde2ff50c Jisheng Zhang 2025-08-23  381  		if (desc->sg[i].phys == (((u64)linkaddrhi << 32) | (linkaddr & ~CH_LINKADDR_EN)))
eae79fde2ff50c Jisheng Zhang 2025-08-23  382  			sgcur = i;

I'm suprised there isn't a break statement after this assignment.
What if we exit the loop with i == desc->sglen?

eae79fde2ff50c Jisheng Zhang 2025-08-23  383  	}
eae79fde2ff50c Jisheng Zhang 2025-08-23  384  
5d099706449d54 Robin Murphy  2025-03-12  385  	res = FIELD_GET(CH_XY_DES, xsize);
5d099706449d54 Robin Murphy  2025-03-12  386  	res |= FIELD_GET(CH_XY_DES, xsizehi) << 16;
eae79fde2ff50c Jisheng Zhang 2025-08-23 @387  	res <<= desc->sg[sgcur].tsz;
                                                                 ^^^^^
Uninitialized.

eae79fde2ff50c Jisheng Zhang 2025-08-23  388  
eae79fde2ff50c Jisheng Zhang 2025-08-23  389  	for (i = sgcur + 1; i < desc->sglen; i++)
eae79fde2ff50c Jisheng Zhang 2025-08-23  390  		res += (((u32)desc->sg[i].xsizehi << 16 | desc->sg[i].xsize) << desc->sg[i].tsz);
5d099706449d54 Robin Murphy  2025-03-12  391  
eae79fde2ff50c Jisheng Zhang 2025-08-23  392  	return res;
5d099706449d54 Robin Murphy  2025-03-12  393  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


