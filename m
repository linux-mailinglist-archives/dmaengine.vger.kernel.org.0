Return-Path: <dmaengine+bounces-7676-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C30E8CC40C8
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 201E330145DA
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618613596FA;
	Tue, 16 Dec 2025 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4mm0TQc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E7366541
	for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898715; cv=none; b=rmiAV7trswQMdddbzvOP/3oh4Byiq4avoUB/ffbnv1QYtYowCH8/L/JcPspwHUhofwEuWmAbWVoDS3Go2e+Vercwm/pWJE7fho9w8+fvsalZNN/AJx7v01M+/8JAVDr3iCXcJMNGerYiHa2JOjw3jrAhUrzhvP4U+86Ak3zpZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898715; c=relaxed/simple;
	bh=MDkvhx/UWht+J1EF6yeI4u41iXTnDyRpJQfMIotkrz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpTMrl0Aj95p9eZkE9c6mME3qy7aT3p4k8hIzETBhLMZFuWMnz2JBRq1sVwLZN5MwPgP2LaYlbrM1RslllcDtZW2Jr7D96cOxGm+eGZqSJQzVt8jRrZPq0w9DqWS49NAk9BJcb+fTT79ikVxDYEPqwNjAqnOlq80EKrJWc7Gtqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4mm0TQc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so51335935e9.2
        for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 07:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765898712; x=1766503512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GMNrMLkfDebdMnrSKqK61b1HC+YKle22T3SSCNCdsM=;
        b=h4mm0TQcwejvOXo2DUDHHUak4AKwWOVwACN2x6eG6RtfkkEmVYzNjovFkKZtq7WnOu
         W2a7P1spHrFj8JG/cdy7MZQZy4ceSc3EOprb0D/2/dKNC83G8hgpURwASTvDq6ttVN/T
         XJL7ZuN1owonTolnqRPKPGi8Dtq4fZHgvEHUeEHFTMMpC7e5ywdUOCQzkLOkSNx8xvQM
         8dGulD+PHtTep81pivIdWu7X9iZyyXftmxquAB+l3FQ6RP4qCD2xckZRcQTLO38VIm4u
         gcUFwkKBjslBOHh8Fn4N7u0ajVGpvWw+PQ3KYZ9odgAK22cSdQ2USKSq/hfMK5+tJR7K
         Hdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765898712; x=1766503512;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GMNrMLkfDebdMnrSKqK61b1HC+YKle22T3SSCNCdsM=;
        b=U9ve5ZbiQ2GikNYIp3eObCP6ppxRE9ctELOYsU1GkxUTD1ArZ4Zh6OlbBzfnEnCVlZ
         JgRiidIojzTudmJ71RAh4o1KrEI1kKA2co76YdAGwo2p1AcjNmRCF91jtWpIXsPsT0vI
         2LQFLEh+d78DDYg4KvH5BDla9q3iKHrK3z03wVO1iuOFCFS9dq2dx8X5aYA+7YBhlg7z
         rq2qWqFdwMZTSIflCzBXKPtrTLP5A8E72oxZ73/E1pNJTpwlootok5Gw3NOLc9mfKUVg
         qXThMF4wJkM2fNETOV4oEb9JjkwQkexlrdw5/nVJ40HuEB7/3fqs49492QntqEy5M/dF
         aUPw==
X-Forwarded-Encrypted: i=1; AJvYcCWfpwdWAzEhJoMdnN5B/KgR3qS5L/0wv7NtEhJ9VnsQwA9xLHAjw+hw+ek9sl3CnCWdVcgTdjNWqUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPK6nkh0Oo4fVosst75ToxyJPHqoY9XUwP4nKA2gPXQSRSBLsf
	xtgHqIgbFcSgMmwf3gfSu5vjht2jGrLnlzaqs0P+90JaVX5XtdNjNw3f
X-Gm-Gg: AY/fxX7x78um/HLuCzYkvKF6pDDCN+BMRZNFU1+N6fEsRCwRjoJnSX5tiIcpryqFydD
	L0t+Rw8+YaD7x4mion6W/yhhHe9tYiRNcth46+dnR4tjpR5GPPjTozyr78jFc8YpHWTF1hYhop8
	/AzoAbeMVRKpbVHJsGV0DaJecIBHMPuOGVDSNDWLnIFoL81ffVdPGA4xhsE4PIo7xaXsNzR9HX/
	wg/Xp7i8jf56Xe3GKbBKgoqXc1d9LVNctxNiG0MBhBq83z4f4dVauoFhA2NzgoPBQSR/I5qBMqe
	IlY2ZdNuFM6nSVPHlgIr8D6hfx9pk2APYZeFPKYMVPipwMdhOVIwUrBmHPxWP8iGaZVdQPnJk4+
	1S+rtG/lzaAhLx1DFkxUAlofCqrKPj3ViQ5c8tNxsU6cheNEngLZSRs6gLeYhnOCVYItfog1moj
	e/NamR50PaIQCPZp+ltzKH7vtQUNLXWUz6I2E1fxztBU+RhVX9gi0q
X-Google-Smtp-Source: AGHT+IFV+c61z+DgSxhQNpcRqsr6GKrDffylNeUc9FZ154kyk76iN8prufaBiE8rBuUIXMcUo/WuYg==
X-Received: by 2002:a05:600c:3b05:b0:477:7bca:8b34 with SMTP id 5b1f17b1804b1-47a8f8ab546mr158959185e9.6.1765898711717;
        Tue, 16 Dec 2025 07:25:11 -0800 (PST)
Received: from anton.local (bba-92-98-207-67.alshamil.net.ae. [92.98.207.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f4b1347sm270035235e9.8.2025.12.16.07.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 07:25:11 -0800 (PST)
Date: Tue, 16 Dec 2025 19:25:06 +0400
From: "Anton D. Stavinskii" <stavinsky@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Chen Wang <unicorn_wang@outlook.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Longbin Li <looong.bin@gmail.com>, Ze Huang <huangze@whut.edu.cn>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	sophgo@lists.linux.dev, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v2 0/3] riscv: sophgo: allow DMA multiplexer set channel
 number for DMA controller
Message-ID: <aUF4w9sO5lmU9T6v@anton.local>
Mail-Followup-To: Inochi Amaoto <inochiama@gmail.com>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Chen Wang <unicorn_wang@outlook.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Longbin Li <looong.bin@gmail.com>, Ze Huang <huangze@whut.edu.cn>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	sophgo@lists.linux.dev, Yixun Lan <dlan@gentoo.org>
References: <20251214224601.598358-1-inochiama@gmail.com>
 <aUE9hDtflXpcgGnX@inochi.infowork>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUE9hDtflXpcgGnX@inochi.infowork>

On Tue, Dec 16, 2025 at 07:09:16PM +0400, Inochi Amaoto wrote:

> Hi Anton,
> 
> Since you have tested this patch before, could you give a Tested-by?
> 
Done. V2 works fine with Milk Duo 256M with 2 channels RX and TX working
simultaneously.


Tested-by: Anton D. Stavinskii <stavinsky@gmail.com>

