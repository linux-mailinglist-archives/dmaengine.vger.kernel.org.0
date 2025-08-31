Return-Path: <dmaengine+bounces-6303-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D492B3D0FB
	for <lists+dmaengine@lfdr.de>; Sun, 31 Aug 2025 07:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B1E443BC5
	for <lists+dmaengine@lfdr.de>; Sun, 31 Aug 2025 05:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B16F1FECD4;
	Sun, 31 Aug 2025 05:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jnx62I9K"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9665A3C2F;
	Sun, 31 Aug 2025 05:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756618414; cv=none; b=VjQfcT/buC+s7VyjExJCxsKb40RfJB1a8qsKNfrMYJLI/AK0OZ+QnixrkvyFII7yxUz+VhCf9dsmyqXI574omHCCviU95QA9qelZ8inXukhjsBUNW44RWLJD19BmMyHq1oj/l7lBMNkZg2kyAyzPSOdll9sJT8yc/2lTTCil97s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756618414; c=relaxed/simple;
	bh=I5QCPFnZgUlcJBqlH4Ls5kRCFJ9A5g4BHkgT80gZBHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UykbR8rl6vrmaowP0UQBbVpj/4FUOBj2C8FXjmdswsYad6eQb9B5zQUUqNAzL3gmucSXy9m4qmlVGveEhy+z7zP3N1G0Dewh1QBbVzetyNvrTF+lrdzNyTnmvsct9SU+zdh76SO7Yii6QoEzXyk3Spuh2lGvA1dtpkhJphovPEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jnx62I9K; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so1226826a12.1;
        Sat, 30 Aug 2025 22:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756618412; x=1757223212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0taoVMBdf5kClGdef1PkaMGGUx00UcRBFrWmgadO68=;
        b=Jnx62I9K/+qjR7mFwMDhCWrltI7jY5dV5WLzRskY0kA4It33R9h0zINndmPGyBPHl9
         Bx/Nr8onTh5l+PUWfw36VeBLhUbQmvwnYzWw3n/7ilodLQg2eqQq8XrIIbSB+JDHzUnW
         /ZJ3k/jcZrVvnznI9Qt6Q8QNYuLu0lUrJuaC2IdXjGSGklHm9xyoCOLhXj35v5BX71LC
         oMOM9qLlNp5ma6K0wIR0HtGitvnQ3c3LGJc4EkXvmVXSdKmTlwqQGPTtRWuOcQmfigGk
         0ni2Uth1VjUwBB6aZOA4PAkx6HJFZpeKxcrHFrk3ArJkXhHgqDORknw7I6iM+XV6Eb9r
         j4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756618412; x=1757223212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0taoVMBdf5kClGdef1PkaMGGUx00UcRBFrWmgadO68=;
        b=nQXCFZVYjis0y/+vzC7zVeKNKo88iU4EOMI1U2GFG1az8Bdg2fEOlFZFQbhkEVdA4+
         ZgQq28ftIYsZO7pjRQfnevXeZb9eLaaxrjYVG/gYueQV+k6HQy+REGWUkq/klsXlwCxo
         O4SnXCgPheBP28gIKoYs584IN5KI1v6ZdDGuYeHh/YEE6iHrDkaNJB/9/LDyY+YznlLm
         GSfosl2cI6oQ4HUhdew1QSbK/mzOjE8/BZqoKCnIICwGWidAzTB/9drXP/hvKBMyfIGC
         19vBaGp61DZM3dxfqcgbSMCPcGXNqShsjB6r0F+VCqwwAhwYbqemlT6xfoUdal0H/sPC
         RiaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNvHloZ877tJIRmSnyNTO3zjWSMa4mXoH2GNWJ7FZJZTWAcX7lj1iIWvG5CvOZIVmH+Md4SpF2JrrSpcM3@vger.kernel.org, AJvYcCUWZKuwAUTPwqrpoZEBANy8hUKKrpak/6C5r0fdaBvDSlObdmjDyJ19J7sbY+3TAasb4ZHBPojbz9VM@vger.kernel.org, AJvYcCVKfAHqmXvbdFcopXeskHZysjzc2aUDd5N95qmbiIbg8pn37uPNqK0HWcgdqpWW2/1bxN/sLZzmBRVn5w==@vger.kernel.org, AJvYcCWt3lAd/vdHLYQaU5v6+0txUJL8rzbGb5kmp+TaJvM7736SUBf2kT9SyT/TttrDC+06yJ0ldFHRSL/Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwG9TRxmrQ16R2BoujWLLbRZiojvURJrw9+oFU9usto92G1f7jp
	7zwSN+x12+cwIi3oQhFDtmShrRVdWQ++P/UZzSsdj8Mql16I5/IJG3mKHhObJnkm
X-Gm-Gg: ASbGncsGOWr541WJN9NzR0+yaX9XMHVCPO3h8ANjT8qChq8umWRnfMrLYlqHFXU9bx5
	FC+bul6W81B2PbCmmle7NUsmWLizmQEfeMcmnxdomMxD+YhdynO3oikhRjWU3FiU3E/+AJJkoi2
	3PDkcB0/XopOThJ3o6GAaOg5uIR+ENd8O5SwUXeL/ctcao9hgHtr37tbIW4cyPG0xxYVIHLJ5fX
	vvs+d9jL2E8uuaOwPcjOxe4sycxFGPavW4KdOyiBU6biwCZkurwYsZP7PGqK+hNZsCJNPCeuWGa
	JbTua9HMOLLQbAPosnwNygjx6gVz5k6sUkSV1JWhxNJIp65TH4Zp5BzSIwaKLFcrj6OetoUoCI7
	cJlkRBOOb0kBlXcg85ujMxwveCuo9wC/nHJxClnPsLeU8dMVyNCZKcA==
X-Google-Smtp-Source: AGHT+IG2ZymWYEfm15+DVFkPLbXhn38VRWp1Ga8GlwAP+Uci6jMte5Dit8DEyxgd1rzI4YiM7BPB6Q==
X-Received: by 2002:a05:6a20:1611:b0:243:25b0:2309 with SMTP id adf61e73a8af0-243d6f7efecmr6039768637.59.1756618411709;
        Sat, 30 Aug 2025 22:33:31 -0700 (PDT)
Received: from 100ask.localdomain ([116.234.74.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327daeec552sm7428987a91.27.2025.08.30.22.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 22:33:31 -0700 (PDT)
From: Nino Zhang <ninozhang001@gmail.com>
To: krzk@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	ninozhang001@gmail.com,
	rahulbedarkar89@gmail.com,
	robh@kernel.org,
	vkoul@kernel.org
Subject: Re: [PATCH v3] dt-bindings: dma: img-mdc-dma: convert to DT schema
Date: Sun, 31 Aug 2025 13:33:22 +0800
Message-ID: <20250831053324.293327-1-ninozhang001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829-peculiar-pug-of-argument-1bfec0@kuoka>
References: <20250829-peculiar-pug-of-argument-1bfec0@kuoka>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 29 Aug 2025 09:53:43 +0200 Krzysztof Kozlowski wrote:
> > Convert the img-mdc-dma binding from txt to YAML schema.
> > No functional changes except dropping the consumer node
> > (spi@18100f00) from the example, which belongs to the
> > consumer binding instead.
> > 
> > Signed-off-by: Nino Zhang <ninozhang001@gmail.com>
> > ---
> > v2 -> v3:
> > - Fix remaining issues based on Rob's and Krzysztof's comments.
> 
> That's vague. What exactly did you change?
> 
> Especially that this is not true. You never responded to comments, never
> implemented them.

Hi, Krzysztof,

You're right — my v3 changelog was too vague, and I should have replied
in this thread. Sorry about that.

For the record, my earlier, detailed replies were in the previous
threads:
Link: https://lore.kernel.org/all/20250824185543.475785-1-ninozhang001@gmail.com/

To summarise the concrete changes:
v2->v3:
- Ensured patches are not attached to unrelated/older threads.
- Dropped redundant '|' or '>' indicators in "description" fields.
- Dropped explicit "type" definition for "dma-channels" property.

v1->v2:
- Removed "Tested with 'make dt_binding_check'" from commit message.
- Renamed file to use the compatible string.
- Updated maintainers to Rahul Bedarkar and linux-mips@vger.kernel.org.
- Cleaned up redundant descriptions.
- Changed "minItems: 1" to "maxItems: 1" for "reg".
- Added "minItems: 1" and "maxItems: 32" for "interrupts".
- Added "maxItems: 1" for "clocks".
- Specified exact "clock-names" list with "items: - const: sys".
- Dropped redundant '|' indicators in descriptions.
- Added "minimum: 1" for "img,max-burst-multiplier".
- Removed unnecessary quotes in "required" section.
- Renamed example node "mdc: dma-controller@18143000" to "dma-controller@18143000".

If I still missed anything from your/Rob's comments, I'll fix it and
send a v4 shortly with:
- an explicit "Changes in v4" section in the commit message,
- inline replies in this thread to each point.

Thanks for pointing this out.

Best regards,
Nino

