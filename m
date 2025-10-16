Return-Path: <dmaengine+bounces-6864-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC528BE3B5C
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 15:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 535A93592D4
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 13:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B3D33A026;
	Thu, 16 Oct 2025 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="J7CgA534"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D38339B3B
	for <dmaengine@vger.kernel.org>; Thu, 16 Oct 2025 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621411; cv=none; b=FC4ckhTwJ2Y7e2OHBZQ1f+pn8foTD5Gjb4qnd/wqo2zQ2+g5X4deTZ01wwa7bfoOBrHE9YFRAlWEVb6P4wIbTtBTYcVILqa3MHncO2ciFVPcQJ0Y3E1caUxIZLth0DNBA6WuyuxJNwvEYexd83Q0qTr/xMrt6ao5BubM1Pg9GFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621411; c=relaxed/simple;
	bh=Unf4UJue+qOxNotOiaiB/gYULcx7VawBCx2grHDb0iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+eVYPXJ0MmujZ0rM7kvNleXMrXp11f2bv9t3WXH1GN/n8EuWI+WqXmyI4YvOvYMhFvCFd5z5HVUfDN+2iz5mlKNpMhFjhs1ZZvxwBkWZOikK7XQYCSjeux3BDF2+ZQfbpSs1Bb4ss3FbMRZgRNq8O1hjIL3Mjo8Vo7APGsbT3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=J7CgA534; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-88f27b67744so104898785a.0
        for <dmaengine@vger.kernel.org>; Thu, 16 Oct 2025 06:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1760621409; x=1761226209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdflzJnMQthLv2cazH+0O/zsQRo0ZmLpj7kbUNZvQac=;
        b=J7CgA534/qOtEhOxg341EWlJqYcd3b29vf0V+hB0LorZVopgxK6oy/+aKTP8I/HlfK
         Al7WA4YCYF41W6l7ch03ECRMmCuY3zlkGE5s8a6VctBIedYWL/34fpfF/tXE5UGC834N
         Xs+/LzmzvkONd4VeQ8YdB5n1HmQNua00Q9XP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760621409; x=1761226209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdflzJnMQthLv2cazH+0O/zsQRo0ZmLpj7kbUNZvQac=;
        b=KiJw9P7J6EFepe/MV2XrlS+nFSTr2MyPlKXvxj4C7hCGZ4RyhzUrRVji34f0SKoLF5
         ZFmiQ0+J7o/SCPLITFEUYny3+fIrZ1XFvXXWIcYaGnkhvbi4OCF1jZCX6ULczlsPxE7J
         w8QPTsrjSnh4eHVgAqwEPCsXg0t7otIVJgKElENBMFjkZPNHLY/+lRaCDa05pz3YYWcj
         F375FvIM15hWB5Z9zFMX/nhrR76O213ZJEin3xIAlGKMbrPPQi8JJCQ0GBwP7Gtl0skJ
         xFIq2OdF1CxOxIxXOPupOH8DObfAZl9dKg6b6DST8AjivAQNB9Jhetegeu1jv70W7F9f
         djbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDiuEtIsio/4GV6oUrnfT0FB5BBecgvaI+6xIhiRPhjT9smFpOSWSNXebDC46WIvYYvUqcIBTLmNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9YRG0OteN4F/NsH8ruZ1kKM5de1QR1UqkuPyI/KWjRj9QB940
	XzDWm6Nz0yLo/RTzlnRKDbaIbA8Sy2qnAYOllNVhsq4MB/U5icOTexFKmwUbrHP6NGQn8csdsvq
	zAhKlkDanfOufLrAnTkDrVzTXjXwDprZy3j0fgSier9COPGvGGev47VY=
X-Gm-Gg: ASbGncsWrtiNCwhZylw4Y+TTEU2dzmPpDcATHNvds2VlkJLB1bjnsoY8NnwhXD019V2
	TlNj2a6TlN7Nfvv4nKpyP+lHqHoofmGf4te0UG0pcWEK/ynX7/w+hmI6Uia5Hw3sLKbYExjycdm
	0DrBmz/kad1FbN6o0AOmVfVLptk1X6PG3KPF/1Y3rYYkIKWmW2tIJu9anJJSjxKFNoigWU8y8oW
	s1N7zOO/sF0vLkK5zCs6D8AkKLZEB3WqJEw/BdOL46J8doDdCZiLtlc7M81aZtE9/tLRaEX3hgn
	UC04jONGylEvehbjJbP/i1zPzR80IE31piQxPtoTPcTCguwXa6+U0CUzqQ==
X-Google-Smtp-Source: AGHT+IGnXn2OWekqEukP5vHXZxC+ehCPf6mZptuvjHzZezwxi/p2zcouk9xm0TfVXXXAeAsJj++O7TUZcBkL3bdq60Q=
X-Received: by 2002:ac8:5aca:0:b0:4b5:f7d4:39fa with SMTP id
 d75a77b69052e-4e89d1fe4f5mr2032761cf.12.1760621408367; Thu, 16 Oct 2025
 06:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-xdma-max-reg-v5-1-83efeedce19d@amarulasolutions.com> <176061935845.510550.12282030175889296984.b4-ty@kernel.org>
In-Reply-To: <176061935845.510550.12282030175889296984.b4-ty@kernel.org>
From: Anthony Brandon <anthony@amarulasolutions.com>
Date: Thu, 16 Oct 2025 15:29:57 +0200
X-Gm-Features: AS18NWA-hxbDFlI3b9UTsQcDU75GuNgix6cv9Elfy_HBgLGvJSUA3uP6hd50TSM
Message-ID: <CAAD-K8bP=cC3Tn9tqqQ74UJSq5YHnkuKNU46kEEr4K4YApqKpw@mail.gmail.com>
Subject: Re: [PATCH v5] dmaengine: xilinx: xdma: Fix regmap max_register
To: Vinod Koul <vkoul@kernel.org>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Max Zhen <max.zhen@amd.com>, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 2:56=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrote=
:
> Applied, thanks!
>
> [1/1] dmaengine: xilinx: xdma: Fix regmap max_register
>       commit: 81935b90b6fc9cd2dbef823a1fc0a92c00f0c6ea
>
> Best regards,
> --
> ~Vinod

Thanks, and thanks everyone for the reviews.

Regards,
Anthony

