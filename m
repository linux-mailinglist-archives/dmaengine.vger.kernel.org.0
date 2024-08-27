Return-Path: <dmaengine+bounces-2976-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ED79613D3
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2024 18:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817BE283D6A
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2024 16:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28E21C9446;
	Tue, 27 Aug 2024 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4NgYzSV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A2F1C86F6;
	Tue, 27 Aug 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775439; cv=none; b=tF7wyWs0my/mklWf4ftwSgQVBC6CWQpKrbb2SXUOGTf56ylyJL3DEcCneoOUkcu+XSJslnL/sRptF+EXjTbVjYjawFK2k/ZChYo6SC06jcaQdSKtKW4Pb9sV4Mm2WfJ3AoS+81s/qBgQndiHLo8uwIgX4y9aFJpO41X6c+n4D2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775439; c=relaxed/simple;
	bh=e9/SnnD2Hc7nrmiUV26PmTlAN807y9TdOycQU6CJMA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJaZWCNoZvPPSURgCb7/8jyxyD2x2qsqWjdnWQ4EvGetjMBr2ztN3erausoO1PAKbopSTvoIcBg3LXYkYgQ5kEf0p0StssXc4aSXQoAazU+pObLCrZyWfb6CZJV24KPZhxK+8tjavkB3+FWUsffMlIYZKrwjAT1jxRx8AMbNgyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4NgYzSV; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6c91f9fb0d7so31364977b3.3;
        Tue, 27 Aug 2024 09:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724775437; x=1725380237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GgD4dqFDyUnD/vStQPVANJoNOpD1Qd5JKsejYAWVUn0=;
        b=F4NgYzSVNY0kVqtHxz5fRXOPW8cv1uShLwF0ZcUJhO1TVrXYJvAWxsjeioERu5TdYJ
         rvyeBTzC8T9QVJKPaHE/XCBpO0Go3RATK/FYPJKiOJaSxUpunBFt6Oos9GWoWGvkdWEb
         BbzKrxNXQLy1Z3zXOINog6Q5dPVklPBUvvZixJYPZP4r2Dn5MTLwT8ZBLs9haTiNBz5b
         4u3k5W+Tg9a82yIbxSvDF6KE1H3ZHfDncFu5VoPk5lfwXMLGAi7asQugasGz9JK0HqYt
         MKG0z0slxNJCwvMrAXdVM+jZcrUiw0TaoqTw8y6V9xBLFNJY+cSKhtrKu7fxKu2gFqPP
         5EIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724775437; x=1725380237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgD4dqFDyUnD/vStQPVANJoNOpD1Qd5JKsejYAWVUn0=;
        b=pqhwCQzn6ka4s1mlOGsbGkimjv9gP4AZFLhCVevZubyQJwkBzI24Hfe5ZDQj4sQKIt
         NFBuTqDNtbFcA4Vyz984L9HKYjzU262GKe0wv+beTSy+nS0hzrn5mIn1W5sE/z9m/UE4
         X4VFWYFS5qEtKklcDlZy2tkd3ELS+N2fQTarTy5QY4/K9ANh0mdRwRAPsEqnOy5lF1ZO
         kqm1a4pAV3zbYaZ/n0RnYP5101Uu/lpz3ix7yQ0VBiaO878/XemkLN5nf+wW47lCEh0s
         YbRD3YmGmTc81KNZ5Y4OkFSJ4280UKkKhbG5GZiM4ckBorAT/eoW/X+E4kFk59brx1+6
         NkKw==
X-Forwarded-Encrypted: i=1; AJvYcCUXeAFtL4KvATtb3dn/9nkkWFUQOH2iWcRtcakN6B3C0x+YmObq4eHaUEPDT2VE7A68qGtzh1FJpcG7Y1gx@vger.kernel.org, AJvYcCUzOdIEuGPqaLy+8l/cZ/c5VwOuTG6lYmKfhGvRJPKHirGfovschkHigkTW7O6SsaUCxund9HhT9qbaVFE=@vger.kernel.org, AJvYcCXAD9ya4HiE1Xq3PRzEPpheFkh0nP3jP5PZ1geX3HMdJtXHXwkXTTuC5aveIDJ+f510Znp3wc7ZKekfDS+v@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Yrnk3Q8SQrmaejUz+uzwBKVwJQW2YWv6bllGM2Imk+TygrWz
	9CXMlJolZmnYzjlo4qROQhFY1iwcg09TXNknY1K9fxLCa2riGtEzh9W/daL0x5bm8laGL2aNCge
	3gyAPUnJpHBmMcMYQ3FDjrjRFXiw=
X-Google-Smtp-Source: AGHT+IHnzsaeAYPx8AAxOBSMK1fpK8G2cmPPm5333uqFeT+rlrVWxKv2QLBzOXLZg8T5AQY4Vh4hdFkNwQmz32UOBto=
X-Received: by 2002:a05:690c:688a:b0:6ad:8bbd:aec2 with SMTP id
 00721157ae682-6c6262f44e9mr177725977b3.25.1724775437350; Tue, 27 Aug 2024
 09:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817080408.8010-1-av2082000@gmail.com> <b155a6e9-9fe1-4990-8ba7-e1ff24cca041@stanley.mountain>
 <CAPMW_rLPN1uLNR=j+A7U03AHX5m_LSpd1EnQoCpXixX+0e4ApQ@mail.gmail.com> <070cc3e2-d0db-4d50-9a64-6a16d88b30df@stanley.mountain>
In-Reply-To: <070cc3e2-d0db-4d50-9a64-6a16d88b30df@stanley.mountain>
From: Amit Vadhavana <av2082000@gmail.com>
Date: Tue, 27 Aug 2024 21:47:06 +0530
Message-ID: <CAPMW_rJi46_2Ho6KNS9NK0kbfc3ujrx-EJ3586wf0u7vq2kUog@mail.gmail.com>
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

On Sat, 17 Aug 2024 at 14:38, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Sat, Aug 17, 2024 at 02:11:57PM +0530, Amit Vadhavana wrote:
> > On Sat, 17 Aug 2024 at 13:55, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > >
> > > On Sat, Aug 17, 2024 at 01:34:08PM +0530, Amit Vadhavana wrote:
> > > > Correct spelling mistakes in the DMA engine to improve readability
> > > > and clarity without altering functionality.
> > > >
> > > > Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
> > > > Reviewed-by: Kees Cook <kees@kernel.org>
> > > > ---
> > > > V1: https://lore.kernel.org/all/20240810184333.34859-1-av2082000@gmail.com
> > > > V1 -> V2:
> > > > - Write the commit description in imperative mode.
> > >
> > > Why?  Did someone ask for that?
> > No, I received a review comment on my other document patch.
> > So, make similar changes in response.
>
> Ah.  Okay.  I was worried someone was sending private reviews.
>
> (There wasn't any real need to resend this but also resending is fine).
>
> regards,
> dan carpenter
>
Hi All,

I wanted to follow up on the DMA patch that I submitted on 17 Aug.
Kees Cook has already reviewed it. Have you all had a chance to review
it as well?
Please let me know if any additional changes or updates are needed.

Looking forward to your feedback.

Best regards,
Amit V

