Return-Path: <dmaengine+bounces-1300-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FA9875934
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 22:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44F0286AF2
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 21:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FD013B797;
	Thu,  7 Mar 2024 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9IcGzz0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD7113B787
	for <dmaengine@vger.kernel.org>; Thu,  7 Mar 2024 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846712; cv=none; b=Wedy1WUtkRYHAdHr8z7TpvLFBNz2Zrx0iYqoLSyEN4CwI+xyHh/vR0iMipP2qoeFQ2sgRiQHza7VdJYSCdWoKJtPqu8JZxAoJVQSx32h7hqZH41vfyLGvmCrbVQ9io7CG2bdNRm96kPyp3hxqz5gDv2wrE730k0miyVBc51t2cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846712; c=relaxed/simple;
	bh=fmMP5iKplWZjMSpRw/sZdefxBphDjLLMtsB0POMq9wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrZ/mvm/qhE0/H9957ziAKmDfExcIJWFnpTCEVtrxjBhqmlwJzAKDPQ1pHkzV6jVHcO7GEi06Y5WmaXwAUGaOh8qCsY9EmEF3hNBDTEW1QA7U+QFlja2LwCAkpIQQROQJEKdzjUytLV8lwCBzZsR8ozngxqJFYWsrHWrJAUFZ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t9IcGzz0; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6098b9ed2a3so14166297b3.0
        for <dmaengine@vger.kernel.org>; Thu, 07 Mar 2024 13:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709846710; x=1710451510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b9hhcys1gNGaG07NYC+PK2//TEd+2vYvb6mO1ZLDuZE=;
        b=t9IcGzz0Nq1flpUvdkBGP5Euh/4CAnc5TKttnLkWvkLIn0vK0i9rW27uOo9+SmUQlJ
         VCzJHkZTAKx47kejlueRP2QE+k5AjymQSVlYHD5qsHOxCA746r7Ga3CVzbtCpph85uJE
         9tDorYeSJPafo9f83e2tH7IoPOd+l2oUH+7b5df3G0ffh5nfJKAxMymyYAF6v8DeZGuk
         2esjb8Go/cTbBn/WpbydR5opCavOrbjnogHsfebj6kS+dF8ROF10DJ7myT/2kYp005Ul
         ZtpZeDSeV3kScmmS4pmy7emHfBqUF45MQ5QP9pPLuCeivqvJAdzhW94033h4yUUaIyWt
         axwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709846710; x=1710451510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9hhcys1gNGaG07NYC+PK2//TEd+2vYvb6mO1ZLDuZE=;
        b=r8sAKNQmji98TM0GDnCfBFpPdas9k8S2/Tzf9jaaOdzUfYMOi41q+GgPAHvsnfZcs3
         Zk+O2wr0b+5u+ZJXBiSmWBtcYygbfhSOEwZJz8I2jqgoxAcfqEgIWuaUXqjeYXX2XccT
         ZpFZh8TdmoMNWeYKe8hq7pf23lSUq2PodKBF81Y5FO7MVRqZoh5vWvbbRPIwTjDppTmq
         M8kjXDnz3zLPcpWgR0upnoaOn/AdEKytQD/11q7GlVOx2ob5Z5lYj+8SrMbHr3H9cmcj
         Q1eufiXwd9NAbFzQ+ptp0APxHE4W5D3ZF/z1F6DVo0E1gYjTmhgLvuVs7YkaJAm6Wg5d
         g0pg==
X-Forwarded-Encrypted: i=1; AJvYcCXKtrn625CaIho4jyZqcDx5PsUqqCm355ONIaejB4QNQ7E3F4dLevUKhyy7zktb99Y0G9ovwMuD1bL/obC/P8Nr5grTRjQRsG8c
X-Gm-Message-State: AOJu0YwxkLHtq3uKanMI+SuNPiqHArow2J+eixZ1CbCzHEM0Rkpa4qxe
	vP/+brEJG6DUE5ddeUkjaKDFBFNu3Q7lzrDRGDRICpj/7NYa2rA8T3JNSlvSR3j+nBxjYwl5IJp
	jGgQBUtW92pPo+yGJ4PPhMhC+dhOVTnUZb3HUxw==
X-Google-Smtp-Source: AGHT+IFeiIPNPn9x5gaa4VWCe7fO1lW7o6wG5lJpI4FhUITzOYaLQsMD+ZKsTXTO2rCcXRWB2h99TPW5M52TItEo/AE=
X-Received: by 2002:a05:690c:fc6:b0:609:2fad:a9d6 with SMTP id
 dg6-20020a05690c0fc600b006092fada9d6mr25256866ywb.7.1709846710102; Thu, 07
 Mar 2024 13:25:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307205539.217204-1-quic_msavaliy@quicinc.com>
In-Reply-To: <20240307205539.217204-1-quic_msavaliy@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 7 Mar 2024 23:24:58 +0200
Message-ID: <CAA8EJpq01SPGnJx-YrM=GDRVD_DjYwMQqL9D9v5jADwd3OjVsg@mail.gmail.com>
Subject: Re: [PATCH v3] i2c: i2c-qcom-geni: Parse Error correctly in i2c GSI mode
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: konrad.dybcio@linaro.org, andersson@kernel.org, vkoul@kernel.org, 
	andi.shyti@kernel.org, wsa@kernel.org, linux-arm-msm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, quic_vdadhani@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 22:56, Mukesh Kumar Savaliya
<quic_msavaliy@quicinc.com> wrote:
>
> I2C driver currently reports "DMA txn failed" error even though it's
> NACK OR BUS_PROTO OR ARB_LOST. Detect NACK error when no device ACKs
> on the bus instead of generic transfer failure which doesn't give any
> specific clue.
>
> Make Changes inside i2c driver callback handler function
> i2c_gpi_cb_result() to parse these errors and make sure GSI driver
> stores the error status during error interrupt.
>
> Fixes: d8703554f4de ("i2c: qcom-geni: Add support for GPI DMA")
> Co-developed-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> ---
> v2 -> v3:
> - Modifed commit log reflecting an imperative mood.
>
> v1 -> v2:
> - Commit log changed we->We.
> - Explained the problem that we are not detecing NACK error.
> - Removed Heap based memory allocation and hence memory leakage issue.
> - Used FIELD_GET and removed shiting and masking every time as suggested by Bjorn.
> - Changed commit log to reflect the code changes done.
> - Removed adding anything into struct gpi_i2c_config and created new structure
>   for error status as suggested by Bjorn.
> ---
>
>  drivers/dma/qcom/gpi.c             | 12 +++++++++++-
>  drivers/i2c/busses/i2c-qcom-geni.c | 19 +++++++++++++++----
>  include/linux/dma/qcom-gpi-dma.h   | 10 ++++++++++
>  3 files changed, 36 insertions(+), 5 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



-- 
With best wishes
Dmitry

