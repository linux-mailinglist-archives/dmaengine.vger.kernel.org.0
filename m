Return-Path: <dmaengine+bounces-3851-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B099E0B03
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 19:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A3F7B645EE
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D931919F132;
	Mon,  2 Dec 2024 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pgr+NJo/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581B9126C13;
	Mon,  2 Dec 2024 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157402; cv=none; b=m2W9TkdAYDsd8qRP3eDP1ChGnGs7nCRKVMPC6tudcfFi84bIn0OGFFGTnuUMkKLrEIa8mAjaAuhAQ9pzlw4y8FdHcP34ij5hJR7hjWLOzVR7TRSiJy0Ill3pCIcqXnO+VEOCHjj25ACKuxAyVysK7/WcU/Ep7WfXPLro0Nc56Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157402; c=relaxed/simple;
	bh=3iIxLX8MdJKmfYZx84Ifi8jJEfVuHKL2dEYMIadupn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKP9+igDayXqTHrziHFMX4OZaPMjP3VzVaay3cGW5e/fImctEGbkmwzQh34SWP/oF8CLZma05eQMUm1s9VPMldqWR5L2wJDvmgsR17JX2IMcdtxIi7WT89An4epfMVwNuGHhWoYBqsGpFFccewehji3RzStKl6dlEJ+knz2mHdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pgr+NJo/; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e3989d27ba3so2072884276.1;
        Mon, 02 Dec 2024 08:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733157400; x=1733762200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3iIxLX8MdJKmfYZx84Ifi8jJEfVuHKL2dEYMIadupn0=;
        b=Pgr+NJo/ByL4jnAftOPwniVU3u3uwOjEvq0ixQte+9GixoTMMVJoaXnR08XWyBJRP+
         2vOoDwgcBgDN+qBVKxmtWbmFuDHaFYeZyDnCI1N913zXr8rYW3Y/7uWXAtkksixzha7A
         6kRad0yzxxc5D18p+7fY/bEsTGKJiAFl4CaesnKbDYJUu+6I4VRDEUkzwZx7KV7dLbfl
         gxu1eL4uRudntWjgeuJh2G9ujAgO7QC8SmzYJYa0WRu2PpUzkjnwNLoZyJvoqwQK5Gus
         oGiu1Un/ObSaB/B0a5ix8LI8RulzvklD094ZtHxCUKVBI0sKE8S/T1LUr56H0q6uluWE
         4qjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733157400; x=1733762200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3iIxLX8MdJKmfYZx84Ifi8jJEfVuHKL2dEYMIadupn0=;
        b=fvOeflT6uMvbn5hubLUvMYd0IYG518KI0wdlt31KZkbrFZLuydyH9dUKFaJdGWIoJK
         Hsz0j/SuOTHVGP8e3oU0IA5xEDRRylvpao/7mVb4U6uLImY+1in2kg73Mr8LEMTaZLpp
         Vw6L2j4jnpuXSoJBVmTOQ8frAf/u+6qxEg5TGjuu/R8Wr5i3lj90pmJYITRSuOb8Y1E4
         /oNvIqkdoSKeHitDpSVZYcgknNjE1qY7tO1Ho7jg9TRUVw5XMkgbRykGp9AGQM+eTnE7
         LyN2c/hQz5FxhBY4d0wQigcmpMmxzRTQqRN1lHmElGfHkYgMmE5A2iT6RFc7SZf5NqBE
         YjlA==
X-Forwarded-Encrypted: i=1; AJvYcCUUP02T3ZAXsDDLOb6oqNIOo2Wn4wdjlYkX7ZUXthRiEVgfTNWVKrKFnKqXJBnTN/UaD3XpnITo8kTblQik@vger.kernel.org, AJvYcCXA7clWNjGKzquhNPOVUYhuJtNJlsJzJQSp7AC6MZU9CgMpIhYOmLzMeRY8Mf3chOahAi3dCw3tmws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmgeIslnVS4faPz4WTTHLFWzZuFqmhAxXgoCeVQTb5k9qx2vI/
	VBDuxPQ7+/ggAkDBLVjErkepdx2xs4gi+S66zAWyKe6R87nrBasp4WB+LlhajaSXKNJlsSxwKvQ
	OJAKTT6Ap29gKAwr9YR3vCVFy1Fo=
X-Gm-Gg: ASbGnctw0cgcshEp3LuLi0zEf4cb4TnzKBuS10JsewqKZtGeeW6O+34S7SHSWoBzFkZ
	rHoK4R9PAcvaRB0x24dH19Kft5LMcPOnc
X-Google-Smtp-Source: AGHT+IFQ4i9gEalC/d1K/SdeClnhnHzZj+IX6cR1THj7nWjoIltHkFk9vX6X4yTjjoj8SQHlC0zxj1n3y1n377U0g9Y=
X-Received: by 2002:a05:6902:110b:b0:e39:7a90:eed0 with SMTP id
 3f1490d57ef6-e397a90f42emr15007609276.44.1733157400328; Mon, 02 Dec 2024
 08:36:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124-admac-power-v1-1-58f2165a4d55@gmail.com> <Z03f08Os/csGbMap@vaman>
In-Reply-To: <Z03f08Os/csGbMap@vaman>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Mon, 2 Dec 2024 17:36:28 +0100
Message-ID: <CAMT+MTTFkVcZHoC77BAVc+R_rvDfhoSQZujic9SCCqb8OkgSew@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: apple-admac: Avoid accessing registers in probe
To: Vinod Koul <vkoul@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Dec 2024 at 17:27, Vinod Koul <vkoul@kernel.org> wrote:
> So looking at the driver, there is code to turn power, so what ensures
> that power is up while we are in alloc callback

There are two devices that use admacs, mca, and aop, with aop
only having a downstream driver for now. Aop's admac is controlled
by aop firmware, which does the power switching. Naturally, that firmware
has it's own idea of how power is supposed to be managed, so we can't
sequence it in such a way that the relevant admac has power when we
are running probe().

