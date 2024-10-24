Return-Path: <dmaengine+bounces-3471-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45609AE4DB
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 14:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2752AB219ED
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 12:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4306A1D5ADD;
	Thu, 24 Oct 2024 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY5nFZuD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D911D173E;
	Thu, 24 Oct 2024 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773278; cv=none; b=ofj3/KFHwOwb+B8IxQqJAXH6wO9t32aYBE3psdMxfuLnAhX9ha3nr4ML3VcCv6wmB5HIPZfi0tPHr5GvSsQ8vBV1EM6kIclr2U4OZWvfog9gwYaMiPqB2qyI/bgQ9a0tVARiCqsYCDYDBUUOxqjhk0sKj4YCkP/RbT0OER98HdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773278; c=relaxed/simple;
	bh=WqKO+VQufYnnSQGNsjJoV9pHpcM4NLycUTcWyfMcgg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfFby7ktPfaM8Je8ZJnyk8skBpp7XZRTCl0OqQC88l6642lhOF7FcfDcgJd+zNUZQ4rB4108yO0VyGZYa3CXHToQZTItxSK0bg1D3Ns8W0bPHGykElhta433X8w+U3+LcLnK5c7UnAkc7FMM5uLjQqkkZ8uIj86y+CtQTwkIUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QY5nFZuD; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-288d4da7221so473930fac.1;
        Thu, 24 Oct 2024 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729773275; x=1730378075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqKO+VQufYnnSQGNsjJoV9pHpcM4NLycUTcWyfMcgg8=;
        b=QY5nFZuDXaIz7hz38L7u08qLHJU9QTkiHyR4KBf6myTWmCmHp27MKIhJecgns2o+4V
         4p4Nh6WlL+7dPV+cor4kUZf/tz9KonupNS9HApE8oeYnBpxR4aCnHZMtz9ocPaZmToG1
         iPR0aRPRA5Uoao8soXfnmCQotbfG3008Y4YhjhCn4TNW9TG4zuGCAZpCmnucgTKms2qQ
         RekgoDPsB2rCltMDzuo/5YQqvkIQv+olENuHTCpkkXryQGKu3KHLQU0aJUkQlQ2Y1XjZ
         4SLGPgeP+ce4YflOV5yjLxVo6xE+cXGe3RdLDd3qzy1d7pHauEowpkeyCx6/lZdQPcTE
         AvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729773275; x=1730378075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqKO+VQufYnnSQGNsjJoV9pHpcM4NLycUTcWyfMcgg8=;
        b=qTiGzFVrMt1EyMsjVxDe4G6XcIKZiDN2rXhI4tpF9MZaLPkuv9FI542kmZAIZPk0Zb
         jmrdSdlLgmS2W6BV8iGiWcF8Nv6od4eQ5lHPL95OdHT46dPUWsUZfsOJ6bMzJZVLs+Jl
         HpZrjW7XS1pW/Gd5MlP3raddszk/0SHshJaL6ctTeMe3F6DyMxs5hIqTNL2mkNBCCufv
         OtrGcxhzYx3J/a6VaJrHsTI41msitnrcSBq2pfEA3gZ7XTN8R6IhUIVDB4dHwNQHJQbR
         Var78HkJSF30nIIMExYAhjlUB9KMS6msvLH7DnW9FGzDl1A5LewYy3cTpg1vKoUalS0G
         UkDA==
X-Forwarded-Encrypted: i=1; AJvYcCU2vvn5noWPlY4iJCBdY9lxNNnYJLqu/IM8Kcd13tGz8snuXTzQFjYhV+9zmYUa8Rl+i2rmkagw@vger.kernel.org, AJvYcCUZsUwqSRJp8CS0WbEEM5aG+2xmLL2xcqFXmR6BH0puZxe9JnnY05HCgAkpDqJZL6A5NUf2HxfpxM0YsA==@vger.kernel.org, AJvYcCUbRy9XuQJFui5oX48VThIyGx4Km9w+KzajCAPMTgzA2JF6ISU7c5B4bn7v7NG0chT9RKV/PDorlmYANw==@vger.kernel.org, AJvYcCV6L293Bp2qTrY+a86NaOdNRC3SGt9y6jeL+9CggvQATYPPGYR5X5yEWF5qvNdo/iLilJObNG1zLPGM@vger.kernel.org, AJvYcCVNAwFpNXUtlp58uCjGEorQWmXFUTf9ezrQRW5AzzVxXS8IPN1W2sV/cHQYwIovHf3KxQ8aq2xpsFo=@vger.kernel.org, AJvYcCVe0wHAc9zlluGKuixl3o0a+io5bdY/JyIaQA8TTRk7u/rIuD85cfznqglOulVb6FmF9v2EiPYHpZNUSw==@vger.kernel.org, AJvYcCVhBRQ/qFqZQz+XhQJXwRWCjrq4YW44Rklq/Yto5cxD7v59BKnrjgjSOe8+SW7uXncDBA6/J5MOZgYU@vger.kernel.org, AJvYcCVuE0txY9BBBIkJgJbv1bcnq/8Ir+eZTNzATDiGHnKB2lXyEMV3cCLJrqUVxnh53Ls0R5i3Sero6qx9rbI=@vger.kernel.org, AJvYcCW27sOniGN1zgpb4M9bDiUYEFc6n8VqBFteaFnAXhmgkvFeHzdLqZzlqjEvW09aR8VRb2bfw30UZUZ1itUc/ZKCkEg=@vger.kernel.org, AJvYcCXCJZv/W+xQ0nGI+Ghuf6oP
 o+pjp6yfzM5+3PYbZcRzbMJtIsKhav+JFtVJdOiIhTfjjxv+GtIuib187QE=@vger.kernel.org, AJvYcCXtXgWsXO4huUUJqnOP4ex9X/XOFIMAfYNpfUYg7FUKFnNXn5c3kshqwaON/OdiwV7N7er/rABDxT6viS0=@vger.kernel.org, AJvYcCXuF1n7iMtbLMswFc+x39qg3hS6vTaTzhPnR9GvDD35bX9zF+2XZg2OhU79Lbdpf/xs0IpZFr54zaqF@vger.kernel.org
X-Gm-Message-State: AOJu0YyMSe76u5tzX4N+ZthQZ0PmmSB32k0KFWPzwBqERw+TJKiPP/bv
	I5wZQzuUvK4oWfLPSe9dm7/fNYXm0onruHPVbc3HOO7Pd4hwnhNo
X-Google-Smtp-Source: AGHT+IGNbdDr4bWOuekBU0ohovYD+u0SLmOKefBPtfh2fzqlR42/5wZYBu+ZqeJfv789Y4nUSEsYRQ==
X-Received: by 2002:a05:6870:218a:b0:277:fb59:b74c with SMTP id 586e51a60fabf-28ced48efd0mr1364818fac.40.1729773275318;
        Thu, 24 Oct 2024 05:34:35 -0700 (PDT)
Received: from localhost.localdomain ([114.246.193.69])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab48f62sm8534093a12.42.2024.10.24.05.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:34:34 -0700 (PDT)
From: =?UTF-8?q?=E9=99=88=E5=AF=92=E5=BD=A4?= <cxwdyx620@gmail.com>
To: jensenhuangnvdia@gmail.com
Cc: aospan@netup.ru,
	conor.dooley@microchip.com,
	ddrokosov@sberdevices.ru,
	dmaengine@vger.kernel.org,
	dushistov@mail.ru,
	fancer.lancer@gmail.com,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	hoan@os.amperecomputing.com,
	ink@jurassic.park.msu.ru,
	jeffbai@aosc.io,
	kexybiscuit@aosc.io,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	mattst88@gmail.com,
	netdev@vger.kernel.org,
	nikita@trvn.ru,
	ntb@lists.linux.dev,
	patches@lists.linux.dev,
	richard.henderson@linaro.org,
	s.shtylyov@omp.ru,
	serjk@netup.ru,
	shc_work@mail.ru,
	torvalds@linux-foundation.org,
	torvic9@mailbox.org,
	tsbogend@alpha.franken.de,
	v.georgiev@metrotek.ru,
	wangyuli@uniontech.com,
	wsa+renesas@sang-engineering.com,
	xeb@mail.ru
Subject: Re: [PATCH] MAINTAINERS: Remove some entries due to various compliance requirements.
Date: Thu, 24 Oct 2024 20:34:03 +0800
Message-ID: <20241024123403.154-1-cxwdyx620@gmail.com>
X-Mailer: git-send-email 2.47.0.windows.1
In-Reply-To: <20241024113246.22901-1-JensenHuangNVDIA@gmail.com>
References: <20241024113246.22901-1-JensenHuangNVDIA@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Well, the fact is that Linus Torvalds, our leader of Linux, is not **Palest=
inian** but **Finnish**.=0D

