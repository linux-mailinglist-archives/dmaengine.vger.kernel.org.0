Return-Path: <dmaengine+bounces-4104-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37066A08FFB
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 13:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D4C188CCAC
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 12:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D719D20B215;
	Fri, 10 Jan 2025 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MtKfUqZB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D2205AB0
	for <dmaengine@vger.kernel.org>; Fri, 10 Jan 2025 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510834; cv=none; b=r3KdVAZTbGoMeKHiR08+Pv22dGv4KgJ7AsPfMwwiWdsVupAyOrZI/p6diQ7BQmaWV1uaOzic3/YrGyA4ewll2JyGfkyipRvkysa329q/WsJvyKie5c+lj5xGMgf/QLA7Doy062Gb9fdi9kJQzHLsn18bO4fywer1RCLSQ8/k8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510834; c=relaxed/simple;
	bh=yrgOy+7BOGVQagwFi5dUb3kJXjLDgLIWtJiBFKqHLoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E35lPqLpaTXy5RD4pqcqXW3D4YfkK7PRC5sPhBovZkiqnb0m+5cKvPLbIQAC73XMQUG23sW2NOLPdhN/2WGJnImEr8Z0TWjBvHGo+1QKCxrSj2D0hKpvCh5f7ZUi/9r6sfD/viAR00lDh1BfVN3lpNhFR88P+Keqvs8qdC/M4us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MtKfUqZB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso377392166b.3
        for <dmaengine@vger.kernel.org>; Fri, 10 Jan 2025 04:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736510830; x=1737115630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9y/gN2odMZFeh47vw+gl1N9CPMYPBQ6DwSsWYHyj4fQ=;
        b=MtKfUqZBBKCcpkJuy/uIdhZvXISYnKuJdEl+wN2wMR+4jWlzn/7AUWxJ5SA4/4c15p
         S6IWCKzRg2wUmsfCFlgHRkUUlhW7n9+q9eI9hLZLSUFZD57MdNOxnX6mq3p/BmaoOtpZ
         lghW7uvevW/maBMpI2uIknTgFtE+qRGZsJlOZEgrwjwjLzfxPhqwTHWkGuSWh9bu2+kg
         kQ7AW9U2Y33GXKOEcNiloevmQokIWGJkFNy9CYfwvNN9As+7qPY38XsmU0f2nqkLHEkY
         c4I6ukoZUmjjLzyidWxSfpLkLRbhXnTb+IAimprUyHrqaIwg1uLH8PY/gX6lbFmCHK13
         12uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736510830; x=1737115630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9y/gN2odMZFeh47vw+gl1N9CPMYPBQ6DwSsWYHyj4fQ=;
        b=bMGIWfny1cbVkSmEXNHw3SrLeRoH+5sVy8pvsuipw/U7CANq3lX6dPF78FfSgxrpRS
         pvfdJ0vG164frFxCalEIf5rgixP9eEsq8GPYlCBmusQZBgDMfFNOecdMcY8OhwuqMwwy
         grdjSeCxpWywzR7zSCiJKGwwfSFwnBhY7jDxWo03hlCHKZgoF0nYMYDsFP58C2pskhz4
         G5cqnJC3G0HcSizLVJbwjh3B5zTNHiszYN0lx3u60oUZ+MwQhO/VTd77BNtFVphGAPIl
         e42IXlgauoyiwMlEiI83AXgx6pP0B9INxhXTjxEueTtGELEkIKHr7l7EknO0l7uJPhc2
         K+rA==
X-Forwarded-Encrypted: i=1; AJvYcCX6ei9ZA9MWFmC3WI22fc6/geXWYIAEN5qCsiYr5g6M4YY9ec6Z4dWgdT7ufcvifBn/eCOZFzsboTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1LfRl1697w/r+JV5/My/JUz2+AY5FkohsO7IXc2wYXfQTXZZs
	/MoWhSQjkxt3Z+rMI2MVZaxv2w08YMUYVtLOpuSDDRgKspmuJ27sXxKoqBWU3JQ=
X-Gm-Gg: ASbGncvN9RX5U9H7McmPiRPMRgCIpqDepqv8qv34/0SpmN0jdGlWrn7cBFSUStJPO0J
	0Py70I6a2GuLIFAKPDiylhvBzfGqrp5Witcm4Bl+aW8/8inPeSM7X70MrF/Yw7e4ZEvz+Z9AAak
	0VpRvRvjkYHqimu08arH2Kc5nntyzJaMmNFQmEI/q9pS4bZNTU3O+Qf73kLVS02YBve7bChHxvh
	CqQE0O8kMqbt2dfbs4JPUMCs1NYPyAL0FoVbintUko9sK8Y1IHuhDyrk/TUac12XUti
X-Google-Smtp-Source: AGHT+IEbs39UX4JebOJPJTtnwI7S/6zwVpYwwRvnr+tFJXOQhZ4ztObQQovV/KgKXag9rMzBNPxGFQ==
X-Received: by 2002:a17:907:3f95:b0:aa6:9b02:7fd0 with SMTP id a640c23a62f3a-ab2aad3f4a6mr1000372666b.0.1736510830008;
        Fri, 10 Jan 2025 04:07:10 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:d2b5:f46c:e0e4:a1af])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90d9b19sm159072266b.73.2025.01.10.04.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 04:07:09 -0800 (PST)
Date: Fri, 10 Jan 2025 13:07:05 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: vkoul@kernel.org, robin.murphy@arm.com, u.kleine-koenig@baylibre.com,
	martin.petersen@oracle.com, fenghua.yu@intel.com,
	av2082000@gmail.com, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_mmanikan@quicinc.com, quic_srichara@quicinc.com,
	quic_varada@quicinc.com
Subject: Re: [PATCH v4] dmaengine: qcom: bam_dma: Avoid writing unavailable
 register
Message-ID: <Z4ENabbDjT8kfpQF@linaro.org>
References: <20241220094203.3510335-1-quic_mdalam@quicinc.com>
 <Z4D2jQNNW94qGIlv@linaro.org>
 <fb253fa0-7877-e1b8-138a-b9d9a80c81f1@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb253fa0-7877-e1b8-138a-b9d9a80c81f1@quicinc.com>

On Fri, Jan 10, 2025 at 05:29:29PM +0530, Md Sadre Alam wrote:
> On 1/10/2025 3:59 PM, Stephan Gerhold wrote:
> > On Fri, Dec 20, 2024 at 03:12:03PM +0530, Md Sadre Alam wrote:
> > > Avoid writing unavailable register in BAM-Lite mode.
> > > BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
> > > mode. Its only available in BAM-NDP mode. So only write
> > > this register for clients who is using BAM-NDP.
> > > 
> > > Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> > 
> > What are we actually fixing here? Which platform is affected? Is there a
> > crash, reset, or incorrect behavior?
> On SDX75, QPIC use BAM-Lite and as per HW description this
> BAM_DESC_CNT_TRSHLD register is not available, and writing to this
> SDX75 was hanging.
> > 
> > We have had this code for years without reported issues, with both
> > BAM-NDP and BAM-Lite instances. The register documentation on APQ8016E
> > documents the BAM_DESC_CNT_TRSHLD register even for the BAM-Lite
> > instance. There is a comment that it doesn't apply to BAM-Lite, but I
> > would expect the written value just ends up being ignored in that case.
> With older xPU it was being ignored but with new xPU its hanging. HW
> team suggested don't write this register for BAM-Lite mode since its not
> available.
> > 

OK, thanks for the explanation.

> > Also, there is not just BAM-NDP and BAM-Lite, but also plain "BAM". What
> > about that one? Should we write to BAM_DESC_CNT_TRSHLD?
> Apart from BAM-Lite this register available in all the BAM

Please check again if we need to check for additional revision numbers
for the non-NDP BAM types then. Or alternatively, change the check to
write the register on if (!BAM-Lite) instead of if (BAM-NDP). That might
be easier.

Thanks,
Stephan

