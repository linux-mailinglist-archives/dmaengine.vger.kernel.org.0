Return-Path: <dmaengine+bounces-767-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C72832A80
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 14:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0FF1C236E6
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 13:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C08524DE;
	Fri, 19 Jan 2024 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fB4wcuiH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C0A5465C
	for <dmaengine@vger.kernel.org>; Fri, 19 Jan 2024 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670829; cv=none; b=bfQySK4gqbKogBmRPEVXBlcEFIPusbpBwmuWUDM+exj057b/ggrbzTL3prUToiJbAkc/WgPTh/zPB+TXM1tTdMO3RFkFQEBsf6tbEU1dQQGYnaFdHV0ocMRwTJDn9Y0FJUH/58fvkgrdzt7/MnLJ80uDtb25zGw4MxZSsRTHi8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670829; c=relaxed/simple;
	bh=tkNP5hdtLMLmdRU6kGCnnq1HZvK5vqTcSU7Mp+tbZQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2G3xei8UvhvMtYRcmJLFSGkSwMZ9m6pH8rsiZcqkLtb/ZGvM6DPzK+hUan54EoJrteCLcrZvhKl1l171QMhPIGhjpf9z35TNqUa4BkX2otS/FbYaN/waq+ikQPvIXI+s/0LlgnfNKh4UFErUKgVD5KZxyzktvgaQ8l9a6Fmnbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fB4wcuiH; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc223463ee4so771198276.2
        for <dmaengine@vger.kernel.org>; Fri, 19 Jan 2024 05:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705670827; x=1706275627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=42jWvBuWK7I9LjSS4bPIwTmo8OJpE10eZpVzP5bii30=;
        b=fB4wcuiH7Epb9QP7/JxhvLWtjh4BnKG0d9lSuS2SuzmdrHq8EdhUtOiACwFldx/wkL
         sgdYMnSCDb6nK5din5kMrMloFFhf3M2P0kao1LPszPtGnb7JQYITE6s1ClX0yeCxkoO8
         rX0sXoyL8Ob55mahZIfsEghci39GEXOu7dHAnzqkTDxlbJASGcxXZoocWZJfQIhbOKcS
         teOciIwYXLwJYDpKAeJms/Wq0viDV+zASrJQpyTJ9oE5FUaxB29chXiuwFiID2NHjENK
         GOlN8QSGtASuQ/igNrTURDBEG1ReCaGWqDi5i1AQEmPh+3G/3G8ZWfIGRG2om1Jg3pYA
         2pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705670827; x=1706275627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42jWvBuWK7I9LjSS4bPIwTmo8OJpE10eZpVzP5bii30=;
        b=HYK55QYtaCwgj+mNpgI3WTcEvyWxSu4u/qtriY+5EIU/dPAFD1wt05XUSuM7Br30jM
         P3yD36Dx6Lted9oLO0gyVzBlz6i4PkQaCeU1vKZ5WfA8QUUS7RnM0wexN9yoOMTw8bMb
         oTAknTSd/apeTtS02ChvPs/EfwWXqwLvruMvEexO9JvOUOSVwq+2tSd/6Nerw3T+AFz3
         SLcaD3fiP7krB10RI97UaUWVhkFEsn2OKR8meYEm2TU4zq7SAg1gTaATU8zGQSLblPBe
         LkuizaPRt3IBq0/mcOPrz5LR0mv9Vi9v9SJje//dwxquHTeMkVz9BUYS633zHJOQQV87
         JM3g==
X-Gm-Message-State: AOJu0Yw+KVRpdhJmQfZgxvjvHcZHvwOgenotsYgsK0LTt0IFXFH45vaG
	0/+5cW3LtZgSY3jvtiZWw2LjFUf6MHcObijR7Xk/7PZpqazm9wMrswV/mj7xX/3Oh0tV3FHe0Nj
	A8LX7PPCUtkknqPC/E1Et4MlqR656vwpxrJ5fIA==
X-Google-Smtp-Source: AGHT+IHcNZ3z0a6KFk4Azj3BQtD3k/0SlfNc1gxTnmWDbYZDfxsy/+8Zo5qiZ4T2sE8zVUc9JU70wOEc2pwAJXP0ECs=
X-Received: by 2002:a25:c583:0:b0:dc2:46d7:d8d5 with SMTP id
 v125-20020a25c583000000b00dc246d7d8d5mr1960765ybe.65.1705670827062; Fri, 19
 Jan 2024 05:27:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com> <1705669223-5655-3-git-send-email-quic_msarkar@quicinc.com>
In-Reply-To: <1705669223-5655-3-git-send-email-quic_msarkar@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 19 Jan 2024 15:26:56 +0200
Message-ID: <CAA8EJprWHiShFpZdb+pWsCoxNvNEoP+3By2x4u8rq+ek37hJXw@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] dmaengine: dw-edma: Introduce helpers for getting
 the eDMA/HDMA max channel count
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: vkoul@kernel.org, jingoohan1@gmail.com, conor+dt@kernel.org, 
	konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org, 
	robh+dt@kernel.org, quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com, 
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com, quic_krichai@quicinc.com, 
	quic_vbadigan@quicinc.com, quic_parass@quicinc.com, quic_schintav@quicinc.com, 
	quic_shijjose@quicinc.com, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Serge Semin <fancer.lancer@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jan 2024 at 15:00, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> Add common helpers for getting the eDMA/HDMA max channel count.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c           | 18 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.c |  6 +++---
>  include/linux/dma/edma.h                     | 14 ++++++++++++++
>  3 files changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 7fe1c19..2bd6e43 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -902,6 +902,24 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>         return err;
>  }
>
> +static u32 dw_edma_get_max_ch(enum dw_edma_map_format mf, enum dw_edma_dir dir)
> +{
> +       if (mf == EDMA_MF_HDMA_NATIVE)
> +               return HDMA_MAX_NR_CH;

This will break unless patch 5 is applied. Please move the
corresponding definition to this path.

> +
> +       return dir == EDMA_DIR_WRITE ? EDMA_MAX_WR_CH : EDMA_MAX_RD_CH;
> +}
> +
> +u32 dw_edma_get_max_rd_ch(enum dw_edma_map_format mf)
> +{
> +       return dw_edma_get_max_ch(mf, EDMA_DIR_READ);
> +}
> +
> +u32 dw_edma_get_max_wr_ch(enum dw_edma_map_format mf)
> +{
> +       return dw_edma_get_max_ch(mf, EDMA_DIR_WRITE);
> +}
> +
>  int dw_edma_probe(struct dw_edma_chip *chip)
>  {
>         struct device *dev;


-- 
With best wishes
Dmitry

