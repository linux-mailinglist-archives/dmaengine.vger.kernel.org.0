Return-Path: <dmaengine+bounces-1299-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5F1875932
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 22:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC88E286CD4
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 21:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2253E13BAD1;
	Thu,  7 Mar 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7ICLbZE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3FF13A876
	for <dmaengine@vger.kernel.org>; Thu,  7 Mar 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846656; cv=none; b=We4L3e3ejhtNG1IGynZyVfxaKLcC5qlatOxytBSviOhLhbTM4zcKmWkDkO6A1H4+l06WPIxFgVKyf7PeRVef/NYOxOFYLB5Ksm5YnVuT9x6TWN+8o1gMSaOhYntXhdK+4I+9Isah7KoldTPKGv1kn1p/GratK1L106m9k1gi2rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846656; c=relaxed/simple;
	bh=XhLpJmKl8D67t5fVzFGtRUMDvdKFUlQhaLIrJCBuf50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LucCzvHJQt3bi3vVuJ905+sGWKw2XSIFlSxdXEAB6KGhoL6kKkstGJDBujhbgwcqrkqJ2rIyDs89WdiyjK2gvh6SiNc/DkHQl26Nix3pNjQaw1D6ZZIoJ7CIA8Vwj9hHhn7RpcpGfwy1eUsq9LiisvbDtJyToz6fkahDf712IvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F7ICLbZE; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dd10ebcd702so1306290276.2
        for <dmaengine@vger.kernel.org>; Thu, 07 Mar 2024 13:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709846652; x=1710451452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Lcyhwp0hIu6sGE2SbZMpxEJNdbFhr0oYQvghcO+6Mo=;
        b=F7ICLbZEgwjVHbluNp+5edKKrOv74ynP1U1dSsvvYIv0+lIXlH2LRS1eQ8IJuMpLdn
         FDySmb8/P0sgeswHZ3c7WAIGTbPeV9UN8V1DOa2nxobKYWTMMYykyk0dxYR8vp7EOMmI
         igmiVGK2ulQi0RTHCctZM0l2U4UxKZEqofBf4RAIzunff1GBOPNy/JeA6b3fXFYVilXC
         FjBa9mcAntvCVMIl/+iVzuzFXggt6tRYx+zBiJTdS0pIU0ytHNti+VeMssUmWAnOjiFd
         sjAibN13vtQPu9h41Q/GyUo7FEvtm3pJhbrnbdkJOjEYTiS5+hO0/fybJx6lRSNuXt46
         3PrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709846652; x=1710451452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Lcyhwp0hIu6sGE2SbZMpxEJNdbFhr0oYQvghcO+6Mo=;
        b=OYrHJL6ig47JA67BvmFyF31Dxqv+4dpDuoUaFGXI7unuQ6F/GS79E5mkzLTzzI3TY1
         VOfWr8fgYCFf1QJy+w0tYLvN3TJUd7AhPp8a0P12u13TIYQ4gDi4MlBMQlB9QWcsU3yS
         6822j3h3kHF3uumwNDVWBcs4YearMhtuRFDL/k6BTRZmcn5/XHJlDZ3uTgGpbMVRlHWd
         W6Pg3D2Zoz1ezq+Yd6TSb2E0IKdMod8aucZti+9tD2v32hMBdoCzGQIftjHRdnr7quRY
         YgbJwRni+Ltn6oGfU+01EkuTA/G+0LR5xActDSC7QNeFZjS6vZc3QeS7+aIQCwOSmkud
         3CpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgpWRMjz22qh9xjEWi0b0W5loG3oUa33YZCmjnK0xQtAFenytTjPw/PIBQr/qLkpUx7bXsuYVl+88FI60nU2/CExVAN9RNl7TF
X-Gm-Message-State: AOJu0YwzFLcodwHp1ji9z7V63ofjWk+8WecTQnKaSlG4G6426/KpGj2X
	HUApmQLXqPfm1toQx4L1fDbYSw11p+X2dA208PxVE1iMUKrO+XEjfFEPg3IDAmW9uwSWlhpwJB6
	uMYW0RAJUUAgmymGmxV2RGCCsYAqj4OrvyhRSuw==
X-Google-Smtp-Source: AGHT+IEZtKFfdvbPeUIrxS4XVLFE0P6vhrrsUowaIoDUL/3Q/uJbZtYQ3BrtlJvKHCcrPgR/wDY1Zvui/M/y85sx3Vw=
X-Received: by 2002:a25:dc12:0:b0:dcc:a5dc:e9d6 with SMTP id
 y18-20020a25dc12000000b00dcca5dce9d6mr17330947ybe.30.1709846652482; Thu, 07
 Mar 2024 13:24:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307093605.4142639-1-quic_msavaliy@quicinc.com>
 <CAA8EJprndszVSjAVs_UzAjhb+x1B1Of4JCkygZ=8kgzuY2RwCQ@mail.gmail.com>
 <25ec87af-c911-46b7-87c9-b21065d70f9f@quicinc.com> <CAA8EJprky=tFjJbGTBL7+9E=kqxQKjxB_RcmzHUt31GqUVfNmQ@mail.gmail.com>
 <eeefab74-1303-470f-bd3c-618d9522d24b@quicinc.com>
In-Reply-To: <eeefab74-1303-470f-bd3c-618d9522d24b@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 7 Mar 2024 23:24:01 +0200
Message-ID: <CAA8EJpqt5H03P-FkpJZCE-9N4=qnd9v+LxcehZmfO6xFz0w9UA@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: i2c-qcom-geni: Parse Error correctly in i2c GSI mode
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: konrad.dybcio@linaro.org, vkoul@kernel.org, andi.shyti@kernel.org, 
	wsa@kernel.org, linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	quic_vdadhani@quicinc.com, Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 22:58, Mukesh Kumar Savaliya
<quic_msavaliy@quicinc.com> wrote:
>
>
>
> On 3/7/2024 8:15 PM, Dmitry Baryshkov wrote:
> > On Thu, 7 Mar 2024 at 15:46, Mukesh Kumar Savaliya
> > <quic_msavaliy@quicinc.com> wrote:
> >>
> >>
> >>
> >>
> >> On 3/7/2024 3:23 PM, Dmitry Baryshkov wrote:
> >>> On Thu, 7 Mar 2024 at 11:36, Mukesh Kumar Savaliya
> >>> <quic_msavaliy@quicinc.com> wrote:


> >>>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> >>>> index 1c93864e0e4d..e3508d51fdc9 100644
> >>>> --- a/drivers/dma/qcom/gpi.c
> >>>> +++ b/drivers/dma/qcom/gpi.c
> >>>> @@ -1076,7 +1076,17 @@ static void gpi_process_xfer_compl_event(struct gchan *gchan,
> >>>>           dev_dbg(gpii->gpi_dev->dev, "Residue %d\n", result.residue);
> >>>>
> >>>>           dma_cookie_complete(&vd->tx);
> >>>> -       dmaengine_desc_get_callback_invoke(&vd->tx, &result);
> >>>> +       if (gchan->protocol == QCOM_GPI_I2C) {
> >>>> +               struct dmaengine_desc_callback cb;
> >>>> +               struct gpi_i2c_result *i2c;
> >>>> +
> >>>> +               dmaengine_desc_get_callback(&vd->tx, &cb);
> >>>> +               i2c = cb.callback_param;
> >>>> +               i2c->status = compl_event->status;
> >>>> +               dmaengine_desc_callback_invoke(&cb, &result);
> >>>> +       } else {
> >>>> +               dmaengine_desc_get_callback_invoke(&vd->tx, &result);
> >>>
> >>> Is there such error reporting for SPI or UART protocols?
> >>>
> >>
> >> Such errors are not there for SPI or UART because
> >> NACK/BUS_PROTO/ARB_LOST errors are protocol specific errors. These error
> >> comes in
> >> middle of the transfers. As these are like expected protocol errors
> >> depending on the slave device/s response.
> >
> > Yes, these particular errors are I2C specific. My question was more
> > generic: do we have any similar errors for SPI or UART GENI protocols
> > that we should report from GPI to the corresponding driver?
> >
>
> Got it. Reviewed and confirming that UART and SPI GENI drivers doesn't
> have such error bits unlike I2C, it simply reports transfer fail OR
> success.

Thank you for the confirmation!


-- 
With best wishes
Dmitry

