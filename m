Return-Path: <dmaengine+bounces-2885-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C838895566C
	for <lists+dmaengine@lfdr.de>; Sat, 17 Aug 2024 10:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C0F1F217FA
	for <lists+dmaengine@lfdr.de>; Sat, 17 Aug 2024 08:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73AD14431B;
	Sat, 17 Aug 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey0Odxe0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3735483A06;
	Sat, 17 Aug 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723884130; cv=none; b=lwXbXfqqn7I2vWtUwubKFMhPx5DdBdGJBU4EbJaJCTeNr2X6J6xcAWupQ2LoPxqwgZAH6E0YemdX730L3rC87qWzjlNMhWOvNgX87yRxzpzlSo+ffee0z177HASxOTH2mODSURoqEBUiWBZHLcvFKaD+gf478xYbiAavTgWgCfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723884130; c=relaxed/simple;
	bh=4I1mupdmsAw4lOp3B/yUB4W64cuBTcGjFf3fQ5QUA/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aob4eNJZ8yXVntQZBt0c6DHU048kOwBCVkcySlAhVm/4OqCgE4jEUgq6zcyw+XsDIV8fkDOb4ZA743ZTyXUABKjn8aRVywJyw3Zo8iiggn2K2X5Kq41kaH1OnDM1qRg3NLSfSMz+U+352F2JCksBJqSlA9nWIKTQLKiDm1B+se0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ey0Odxe0; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-690e9001e01so26716567b3.3;
        Sat, 17 Aug 2024 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723884128; x=1724488928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9eMsJxTM2zOmRS6+tqFj/KXfj/XkuR+C/+5c8VgCc3Y=;
        b=Ey0Odxe0Wbhb9bEsw+P0AMrrR60tiY26yV4NAmv3mJz6Ec65/tLTaHS2q3GGGqleD2
         aTAZHAYWR8nKrmvhlg9eUl4FpdhuWmpl5hAdtWB3pBqWT+eoUmL49r4cckRBY3X5EOak
         fR9uLM8l+9hGAH+3jTDRP7v2N+hrlp7H7JY7re0XRyn0WmaoB0dH55Xw4YBtW9q3Dvge
         MdZh/3DRCsYE/jNgjjzjUjvPhpuHEm69Jkk5dQB+nzYWwWtFzCikXCWp0EEbGCxpvSgU
         6mxpzHWmPh+9oIR9sFtgHaQkMgduMZZ+IuJC73rtVyU4n0+k0oRy2+BGv0gh87g3LTYH
         Qblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723884128; x=1724488928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9eMsJxTM2zOmRS6+tqFj/KXfj/XkuR+C/+5c8VgCc3Y=;
        b=NSkgTPgnIwDE4SUUHMNZLqy30IZv6pdsUuGuJ5D9zbZ3n+w5kNU+NU3/27nweozV4Z
         c7bc+DlP22fzKv4uWN1EbLMo8A58GMDzWK02/QLiZzCLJNOjxJTgCC4AbV5isezvRD1k
         lwkDNnBoZtAGKOKMA9w3/Jz8o3yZqz3X7A8EbDibAphFvryUY29mIVPP0EnovIhup4mq
         LmI/jlHo78DqVucg0sL2gHHIbnH9i/vYe+TI/q5YkA7SWhysZFTCMlxwPLUz48I/kwh/
         L1d7wQHsIWyGJNlrIeGR2M/RGYeymsOECuGvf5xubguxZPWs4jYnVwDj0WCVJ6kYa759
         VJUA==
X-Forwarded-Encrypted: i=1; AJvYcCWoFjpWpYq9VSvWOlxPqohW29cT+4x3D8aLT/N16lGeBoNhGN0GwpNtxX1agzgHBfDZ69jELT8S+PFnWA3mMQQUG0RONiL5n7thSIX6H1bSzaY16WvbDdInzh3oeCAGc21cmB10jeYUPr1x0PA947z5l6UpslIbCnAY83XGm2rtXuHWj3aB0gfM
X-Gm-Message-State: AOJu0YzU2VGqPdGy528/+O8wMioCcXAR0dUJfjTkICgVKYPAvD/f92C1
	SELeuSPzKWM1wXc9ZRWc8XzW8Vlt56r0Pgba2prnflNJUZCMylPdLgs4m4vbZwUueXDGZbQ7MMC
	w2tf1kLHQwZUAVGlcN3Cn26mA/Vg=
X-Google-Smtp-Source: AGHT+IH/bN7m+GREt6zV/O8rtGprxJFVfkBD2hfqkVRmLL3zNnCApsctC6ZVhzVCMOnM1LN6O5ppOC8r090pASW/sGE=
X-Received: by 2002:a05:690c:4:b0:646:5f0b:e54 with SMTP id
 00721157ae682-6b1b9b5ae86mr67136927b3.8.1723884128092; Sat, 17 Aug 2024
 01:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817080408.8010-1-av2082000@gmail.com> <b155a6e9-9fe1-4990-8ba7-e1ff24cca041@stanley.mountain>
In-Reply-To: <b155a6e9-9fe1-4990-8ba7-e1ff24cca041@stanley.mountain>
From: Amit Vadhavana <av2082000@gmail.com>
Date: Sat, 17 Aug 2024 14:11:57 +0530
Message-ID: <CAPMW_rLPN1uLNR=j+A7U03AHX5m_LSpd1EnQoCpXixX+0e4ApQ@mail.gmail.com>
Subject: Re: [PATCH V2] dmaengine: Fix spelling mistakes
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ricardo@marliere.net, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org, vkoul@kernel.org, olivierdautricourt@gmail.com, 
	sr@denx.de, ludovic.desroches@microchip.com, florian.fainelli@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, rjui@broadcom.com, 
	sbranden@broadcom.com, wangzhou1@hisilicon.com, haijie1@huawei.com, 
	fenghua.yu@intel.com, dave.jiang@intel.com, zhoubinbin@loongson.cn, 
	sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, afaerber@suse.de, 
	manivannan.sadhasivam@linaro.org, Basavaraj.Natikar@amd.com, 
	linus.walleij@linaro.org, ldewangan@nvidia.com, jonathanh@nvidia.com, 
	thierry.reding@gmail.com, laurent.pinchart@ideasonboard.com, 
	michal.simek@amd.com, Frank.Li@nxp.com, n.shubin@yadro.com, 
	yajun.deng@linux.dev, quic_jjohnson@quicinc.com, lizetao1@huawei.com, 
	pliem@maxlinear.com, konrad.dybcio@linaro.org, kees@kernel.org, 
	gustavoars@kernel.org, bryan.odonoghue@linaro.org, linux@treblig.org, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-actions@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Aug 2024 at 13:55, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Sat, Aug 17, 2024 at 01:34:08PM +0530, Amit Vadhavana wrote:
> > Correct spelling mistakes in the DMA engine to improve readability
> > and clarity without altering functionality.
> >
> > Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > ---
> > V1: https://lore.kernel.org/all/20240810184333.34859-1-av2082000@gmail.com
> > V1 -> V2:
> > - Write the commit description in imperative mode.
>
> Why?  Did someone ask for that?
No, I received a review comment on my other document patch.
So, make similar changes in response.
>
> regards,
> dan carpenter

Thanks,
Amit v
>

