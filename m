Return-Path: <dmaengine+bounces-7144-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4E2C56D39
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 11:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F92B351E45
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 10:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EFD2FE582;
	Thu, 13 Nov 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2dtIEjpw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1A22E11D7
	for <dmaengine@vger.kernel.org>; Thu, 13 Nov 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029587; cv=none; b=HXnfPUZVCcLRJRlhQq2KXxdv5TtacM0LdNvJOp2ZPwBMNYvp/DEE+eIGtxWiL4W0O9d2aFrqDVIJLVrRwJ/eDWvENhsp3nZfNWLdaLqFyqCQn/jhENW6ciyk3yfl1U4tiuFgJ8HKb5OrNpWSTR+AHBZhbodCD/WDAGT+nUOBISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029587; c=relaxed/simple;
	bh=y6pEkKmQUrDvPxt44l7tHq8+XpLO4nw6MEi1Gb1kcGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYBZvYxQifEf5x7HJt8pYc8KiCZ5ibf/WUmokiNAFFbuU6t7C19o4dQDDb7olf9r7jTKJwTyzrsiJ1SyjDsKH32UaLhD2g9BlgEZ3Vg3eXKLVHioowbhD54vss7VVBfMnYSnmrFamEp/xa8AtIwmjsQpEIeq38rvas8uorKz9IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2dtIEjpw; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59583505988so19678e87.1
        for <dmaengine@vger.kernel.org>; Thu, 13 Nov 2025 02:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763029584; x=1763634384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6pEkKmQUrDvPxt44l7tHq8+XpLO4nw6MEi1Gb1kcGw=;
        b=2dtIEjpwiNbMUp8AZbKJSgnT9yMeRacX4NcpcYG81Oa5M5Nnvd7rnwNiGv+mZJwACP
         RMEGaVQ/0+Np3BEXipQt2op57p+v5B6cAUqD1jQLnFrjG6bWfwvFZwSvekAnfpdE5DuR
         a3l8Rcrph4uec9OhuV/JYYPKCjsq3nAayFwBur8/sTMBnHTxAtf2l+g+fOLt0adkPrNL
         biegb8Jqhw7C8XS5QBaGyQD7Mc6ZPe72IFXyZPOZidjVZ1kqKzBx6lzMjX0mjMWBK66L
         bRPXWTJEGUQMI6TynH0pv/9wurwU0C5j7II7sHJJ+J7OtFU+i3Yv5GMSYtU+FFVrLvnX
         yOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763029584; x=1763634384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y6pEkKmQUrDvPxt44l7tHq8+XpLO4nw6MEi1Gb1kcGw=;
        b=PT37CWctKwOPrm57Q7CbY0yo1YG5yggG+vGhyqBirO27CFWbIUqCFOI0mTdcOKhZFd
         5mAgmmBUWekTj2cMDDtGA6OIQTLpIYUVGAYqgnDxoNsSNUeT3b87ODHsFsSuEG+3XQY0
         ceubBbOahthT8IYG0KTSarSMH0WSxaxcoS10gY3B6IZwxbALS2btBGTNs4eFF+DFY1vF
         Rc8dfzYp3dGH+t9kFoKr8w5cInqH/Ked3GYrl0Z6FPpDHQnrRy1Ip71ToyQJs4FK6bTJ
         r6Y8gw13xcl5RA6krAmBASAbJ33dF9qX5YJEtCejA/o4vq90DLqvPOveN/I00MK5yUbW
         9XxA==
X-Forwarded-Encrypted: i=1; AJvYcCWc2TDQ3+CB+izPNYoPMfCYD4+zwUdAFspcWKmgMkpRqtQJRVtpYQYHXJOLzRpT52srK+SZGIT1LMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlD9yqVi16P+P4tA37ri0cr/klmERyqqsZzT6XVNgqeTEGLA4a
	0OEEAKr3rGvmYx12m2HffmqK5cMU5WXJaqvbX6P7N2Oi6jXp4gnkdJAt0XsXhgoriG3cmyN6ggl
	l0mkXUt3XFI6rJOav1bnRehNFqyYpy7vZBzqNYzEqM491amzagT27mrg=
X-Gm-Gg: ASbGnct379icE7sSmdJNGB6Qxb6WFfXvry/1HMOQIMNt9HTqh0garDSza+kfejijPfT
	zKODIqQp7EE4uHe2fCm+da1LphmjOqyIwae/hJk58HkG+fr0AMyun1Nb1/tZn1VDK1kuVqF3Pv7
	ppZzwZXNP/o3uw52aFWntpLuHMVIuBFIoPSIF/5I/KbySBgoVYxa0Jq4UZEj8OnTcTcuCwzr6hG
	ftWyV0nASMaMk8rA9iJj5YKr2L6hH1TmpQQ8stht8BSHvfXUedM+zKU4YVGvgtoBDqeOuv/PCEU
	YRvkIEtGo3IF+q90
X-Google-Smtp-Source: AGHT+IEWBz0+be0FB+wLbE+7QTcc/OUWq0TgJqUkR7RRmlidFEPDPpiNSaVnc53Ovz4tW1nSH3J0cHCpYlG2Y5YBezE=
X-Received: by 2002:a05:6512:ba3:b0:594:1279:dfc0 with SMTP id
 2adb3069b0e04-5957ecc4170mr718381e87.18.1763029583635; Thu, 13 Nov 2025
 02:26:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-qcom-bam-dma-refactor-v1-0-0e2baaf3d81a@linaro.org>
 <20251106-qcom-bam-dma-refactor-v1-3-0e2baaf3d81a@linaro.org> <rrw7q7cmkaykng5mnyqk5oxsjednptx3yvjilh3tf5uub4nxzh@p5a4sbgbaha2>
In-Reply-To: <rrw7q7cmkaykng5mnyqk5oxsjednptx3yvjilh3tf5uub4nxzh@p5a4sbgbaha2>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 13 Nov 2025 11:26:11 +0100
X-Gm-Features: AWmQ_bkPrLo5fkHZmAca_a3y1ZYvX0iZcUyH4co_j7LpID1i-okvegYKSrVQn6Y
Message-ID: <CAMRc=Me1DA8ajey++S6_gTP38oDfJKv5CzZbgL5trDC=zT0NYA@mail.gmail.com>
Subject: Re: [PATCH 3/3] dmaengine: qcom: bam_dma: convert tasklet to a workqueue
To: Bjorn Andersson <andersson@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 5:15=E2=80=AFPM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Thu, Nov 06, 2025 at 04:44:52PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > There is nothing in the interrupt handling that requires us to run in
> > atomic context so convert the tasklet to a workqueue.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>
> I like the patch, getting off the tasklet is nice. But reading the
> patch/driver spawned some additional questions (not (necessarily)
> feedback to this patch).
>

Thanks, I can look into it once the locking and these changes are in next.

Bart

