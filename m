Return-Path: <dmaengine+bounces-4156-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B14A1605D
	for <lists+dmaengine@lfdr.de>; Sun, 19 Jan 2025 06:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854563A0345
	for <lists+dmaengine@lfdr.de>; Sun, 19 Jan 2025 05:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE4242AB4;
	Sun, 19 Jan 2025 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJ1me90m"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EDF2B9A5
	for <dmaengine@vger.kernel.org>; Sun, 19 Jan 2025 05:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737265273; cv=none; b=GSLJY248mNM8I1kqyEGmbavcOUNl3g2UY2/hOrLD2JHxepUHLCFCtE95TEAb//0TMirQFp7nd3zBD2aTksSz3QTUUfF+BYnlvsOXiLdPmc7lUMIvulv7fMUv/Uux7rSRwvT0ef77CRRGg7TqBv6RKCXmS6lCYP/Rd3QcvsegPBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737265273; c=relaxed/simple;
	bh=7wiEiBO65qt8hUOF1czRxQtBtxWFL3rfJ9lF5CVTyn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glssHhP55M3eImX9OzhoADz5trr1s97YUUZ/Bi5pCZZtj5dNQauxKgVSa6LEALy7WQ2+xWGJBPg0JVi6ED/o09WfrnAneAY7ZSHcT/FVUog/3tAqvhrlZT2SVq7Ii72wEkNhziEqr4Y7sDc6Ob/L3aT1+lt8sjvjoJMUn+HgAD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TJ1me90m; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso4721710a91.2
        for <dmaengine@vger.kernel.org>; Sat, 18 Jan 2025 21:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737265271; x=1737870071; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q0hiYAmC1NBHRz5E16AsSt6i/zS8INIR8RO6iwr/sB0=;
        b=TJ1me90mrf9p0V1PbgDGpdW9+1EKXfdNLuEWoW1v+Q+E6beduVF248+e/tJU5cg8OC
         eTlaA1K18X/KHljglcp/X4NW91Q18mMn9ZN868xyV+HlDstRygvOZbZ5/inbEjZVX24b
         YWd7kG5uziSYnpd2CC+DUY2m+1Ef2NcRhCmUC1gqOFnoCPKGmItcYzkwSm+lxcCzJFU+
         DAAIbFuECSkQKvf/2AjhojZRXqgwbU7F97//Iy/P59cCQvGOVO1ZU4r6KdjYafBFV6/s
         Zngq+FFIXo1JJ8+u3Ti44W8wS1t1Lw0lHS76uTHUuMEzxtOAO1gYappH1un3lmqczpKr
         zi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737265271; x=1737870071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0hiYAmC1NBHRz5E16AsSt6i/zS8INIR8RO6iwr/sB0=;
        b=n6v2+ZqhnwTFkXLPYaNgsXpVARARM+sMIp6Y2KPbN0Ks9IOFFUCFi04KzKf2sIdcz9
         fo1bqfyzDqCzB2cV25BSOJTieNkRdSS8AHPB5w1DyO8oX8Stgogc5BnI9cfuxsc1Zm9c
         6vt3UbcT1kNQ5QtfSmaIMxh9glQlAib2IODVovaBZS0PWfpVhWGvgS0n4el4lECdiaql
         HC0priDOzAZN9HxHOSuqYuNsDcwp5Spn/L3hAXsnjVpFQnBhweZnspth4VRTGrPeyNu6
         iiHfXSM834orm/EnpLrbODpnqyGxLL9jZsteyPumS4IBMlwdc0APNJQ5eHUaLJ/2oJl2
         P3YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmPFFI8pEdsiMykvpQY+PyK1dxLtjfh464128NORXzFy9GjlgLx8QqSuqfMZz/d1hnhlyzQIxQuHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm6D9rqjC98METQMLj2xWxaYqYqefuZUyFriVISli0SnoKCpsH
	5Nmz9mh1FnEoMWbj+EZzEaK0BXNOP3dvCFPHBUgui3Uqi9Kuu6pAuxz5K6qp4g==
X-Gm-Gg: ASbGncs8wFYDtyQrzubyWNqBB11S4LUwx3dfaEH+YZByNz/7XTK2J68dvOl6OiNUrBv
	ADv1qC+ksu9c0rndN8Yk9l9H2lZmY4Q77ZapTHuDbnMS4dawIfhYuqNRV9xd+ygC3SB0kRc7WBV
	h5cMbRW/7blu6ssJ0yLbLIoAefA3EtZ34HTuUpIgyZRnTSn+gn7N09nJUvDvtWNiLpoq2foScvp
	podd8L+0qG8rTSXXKsChLKOUMvJmv7mNsOQl/YJGH6qgJxNX1+3iKi3DXp1mwHmMWsXDGxiXAF1
	RUbAOA==
X-Google-Smtp-Source: AGHT+IFTPFAuCVR47CqJZ5aE1a4b2WBsAqSxOx0hT2JepHYK9FHRggwrPcIYivOgfSXepJdzgdFTgw==
X-Received: by 2002:a17:90b:4b82:b0:2f4:423a:8fb2 with SMTP id 98e67ed59e1d1-2f782cbf6a3mr12954407a91.20.1737265271093;
        Sat, 18 Jan 2025 21:41:11 -0800 (PST)
Received: from thinkpad ([120.60.143.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7762acd87sm4995908a91.43.2025.01.18.21.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 21:41:10 -0800 (PST)
Date: Sun, 19 Jan 2025 11:11:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: vkoul@kernel.org, robin.murphy@arm.com, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_varada@quicinc.com, quic_srichara@quicinc.com
Subject: Re: [PATCH v2] dmaengine: qcom: bam_dma: Fix BAM_RIVISON register
 handling
Message-ID: <20250119054105.rhsathhdqapirszh@thinkpad>
References: <20250117111302.2073993-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250117111302.2073993-1-quic_mdalam@quicinc.com>

On Fri, Jan 17, 2025 at 04:43:02PM +0530, Md Sadre Alam wrote:
> This patch resolves a bug from the previous commit where the
> BAM_DESC_CNT_TRSHLD register was conditionally written based on BAM-NDP
> mode. It also fixes an issue where reading the BAM_REVISION register

The 'also' sounds like the patch is fixing 2 issues, but it is just fixing one.

> would hang if num-ees was not zero, which occurs when the SoCs power on
> BAM remotely. The BAM_REVISION register read has been moved to inside if
> condition.
> 
> Cc: stable@vger.kernel.org

The offending commit is just in the -next branch. So CCing stable is pointless.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

