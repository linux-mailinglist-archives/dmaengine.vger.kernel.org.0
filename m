Return-Path: <dmaengine+bounces-7379-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2BCC91EF3
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 13:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 29C4634289D
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 12:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F138D27B4F7;
	Fri, 28 Nov 2025 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbvGwAAP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBFA303C8F
	for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764331515; cv=none; b=RmnDD3bjwD27ROyrKLnyde65fifAyh+R6p1hPpc/TqbVINFMOU3Oiv/4xMP2Mq3VEAAQDhSreCYFQKyy7V2fI1Z+/Y6nafoyprOn7/D/1bT8nZQP3M92Oehxhyw6CYfPAtXSp+dVPBabjNyRQz457NI+FWpqJdlHn2XBovWmLr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764331515; c=relaxed/simple;
	bh=PLh0YYqKKtVf//IZFwd4BXKiwNuaffkN//mL9hOePbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2DpIb0LYWZIoW5UxE9gp4oFnBC49kmZYUOYPWiQfM+g82iv73iLfwiUFhnQ1Y3GfbhQ0CceYOFcvEsu6Pd1mHCUDrTNZFwqTZ0v+JBPnB0csn9LLOQBoRfpj3AshBVMeTVbOvv3m+X0jpqkYmN+4Fnt/XvO44cBhbl2vsdotQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbvGwAAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80380C19422
	for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 12:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764331515;
	bh=PLh0YYqKKtVf//IZFwd4BXKiwNuaffkN//mL9hOePbM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RbvGwAAPyPMSixzQzyVeqVBgwInMAQJFjSvP2xNNhH8Lfo1MRkFJzZnAbUpOpU8Gz
	 2Wgpga7Bl0QR/ivCHvq/qtBPWVHHmtqR5oUyQdk1IY376o5ZtuAnE8ZGK8cD841aZ+
	 t77Yohdpu8C7b3eGA/P3PbobHyJtNE4yCyY0YBJtjhwKq/Y37+HR1x5T0g5l8fI+bJ
	 eMxieM8Jo/Xkq88zivnKOE42ZKxWz5C8q4q0I9bUdWHzh2kGds30U+3yLF5CGgs+B+
	 ynaNLQUXRuVmjEFfaDSGcowvGy29OiFsfOeJ4nnDuZHt8hNaI5A+uQBRXhhaQy+eoD
	 hsWikdMFvu2Dw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5957c929a5eso2742057e87.1
        for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 04:05:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkA9Uaw59wtkUgaByf/TC1KURCrMsIhJKeqUZPKz95A9pCJg0u+d58+Deery/TWs/fh3c3+06xg5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Xl7yXO+2F79lWTzTrTUJnmNz0sE72w3j1mkmFOj7rrTDVisg
	wUCCj594GlJNtBMeDSfTP4x4Et5u6D0x/RotkLCrmoesJsFuVTlEyielbgv+VpdhlTaTtMgdjDn
	TmpHbWgZxoQ5T5X1ql+8UryXbOigk/P0hG/b0B3tLxQ==
X-Google-Smtp-Source: AGHT+IGQ6Hj12QsS85blhF49x2TTlICoWGDxlwIhIavyJN6qeiKzvLiOIBy0mwSV2CTlhl6dAIHoyhSGp7Rq69/Jdpc=
X-Received: by 2002:a05:6512:159c:b0:592:fd2d:71be with SMTP id
 2adb3069b0e04-596b5285dc7mr5376568e87.34.1764331514089; Fri, 28 Nov 2025
 04:05:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
 <20251128-qcom-qce-cmd-descr-v9-5-9a5f72b89722@linaro.org> <b1d8234a-6d29-49f6-bfc7-bdc738895d79@oss.qualcomm.com>
In-Reply-To: <b1d8234a-6d29-49f6-bfc7-bdc738895d79@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 28 Nov 2025 13:05:00 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mc0Mh5CjS0C+Ss-AG1qQ2YPOr=kkWc+Bbk5CLgPoPVrqA@mail.gmail.com>
X-Gm-Features: AWmQ_bnN4NlR26dNy-7lGmNw7aEJzVFRbeeSl6p6s5KAdU3TnKlS0JNANPCTfNo
Message-ID: <CAMRc=Mc0Mh5CjS0C+Ss-AG1qQ2YPOr=kkWc+Bbk5CLgPoPVrqA@mail.gmail.com>
Subject: Re: [PATCH v9 05/11] crypto: qce - Remove unused ignore_buf
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>, Md Sadre Alam <mdalam@qti.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 1:02=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 11/28/25 12:44 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > It's unclear what the purpose of this field is. It has been here since
> > the initial commit but without any explanation. The driver works fine
> > without it. We still keep allocating more space in the result buffer, w=
e
> > just don't need to store its address. While at it: move the
> > QCE_IGNORE_BUF_SZ definition into dma.c as it's not used outside of thi=
s
> > compilation unit.
>
> It's apparently used downstream, at a glance to work around some oddities
>
> https://github.com/cupid-development/android_kernel_xiaomi_sm8450/blob/li=
neage-22.2/drivers/crypto/msm/qce50.c
>

Thanks. This driver is very far from upstream. :)

I think it's still safe to remove it.

Bart

