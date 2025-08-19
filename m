Return-Path: <dmaengine+bounces-6072-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC5CB2CB77
	for <lists+dmaengine@lfdr.de>; Tue, 19 Aug 2025 19:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1C6624047
	for <lists+dmaengine@lfdr.de>; Tue, 19 Aug 2025 17:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC51530DD0F;
	Tue, 19 Aug 2025 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQpLuwh5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B27A30C36E
	for <dmaengine@vger.kernel.org>; Tue, 19 Aug 2025 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625772; cv=none; b=OHlEC201xSW8atcL7vvnLvUT7/DNCrawj9ngQ8W3Oq1WUEKIZwXoim3Atk/fofJxcG3JSz9SJ/83hRe2iC3Nw7Y6L7/vCx8LGENkUZ4rchs9ve28d+rfdNvMK6x1c2iC6qN2UgB719VXlZBFBN8o4g3TpPBH1Hhh1yDlj+JKkMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625772; c=relaxed/simple;
	bh=YWkp7me/aGAqDor+8g4ul51C+lYC9lu/O53kvPxYg4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwFmOiTL4dh/nq3qoQx2j+zuF4G04iwhuy1WCGESaHDxU6X6xt5353Ts19wlPdahzd9grYrhPUMszYiWntnqnFB9eS2CIT/w7ktgqItzOA0t92kjSw8lhRRpaWCftoLLRkwi9HoSIRvg8AVQV+cR6vbK/ewI1Tps0Dui487f8Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQpLuwh5; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-50f8b94c6adso1370633137.3
        for <dmaengine@vger.kernel.org>; Tue, 19 Aug 2025 10:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755625770; x=1756230570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWkp7me/aGAqDor+8g4ul51C+lYC9lu/O53kvPxYg4o=;
        b=fQpLuwh5yNqxvx9BovYEUoVO+U8lWGFmgEesys7A/OYKL61yjBESefcISBOmwUZeGH
         3yB8ZFvi9hdElBnMaPONv1t/vtiFRQ02WNr3Dh/DfRWhKfEF9CBioPzfgyxsgJjzceUe
         a9wix2Va8aRJe4II7SvrGrqjrYSUvRT7k1/3v7UE1Ejkyuhy5LrzrDlJDP3SYBts1jS8
         vyVp3ZGH9bHftyzCazeD7IpKJYxMZvyzt4F+53YG9kr/vFo0qSyWTajVVAd0WWuUf94h
         GjbjCKVb9hYhhweO9vQE7b318m9OT5IvzoNM0WfV8p+cU6W9cqYMxqoMubxtYa5biAIn
         cgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755625770; x=1756230570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWkp7me/aGAqDor+8g4ul51C+lYC9lu/O53kvPxYg4o=;
        b=vlPXqzNVkWlILE2b/y7oi/Sr81SSumjNadiOz44+xzXc2waL8AgGQO5cu8C2Rr3yyI
         SIOb+4dCrzGpDiT6jJt/Ua+Zikb95QJO8Ly4OS0wHnZl7/eMMQ1R3Ng9v8s0IFYDTwHa
         dlZPMygiK4xu1Jx2V+6Div557xTDR0HWHBtuZRQ2u8VDACz7UAlBvcvPmNeyaCLI1qjM
         34gH5asUajUzxnnXNpoemFC0FYnFtzzLbAv5rvBekthPWegoRMhcNezaFgb3otrY892/
         QcKuIsMzQT8xXyYqTYtFICl+Rvt5e3E1JXpuPOkE/tuHmDCol7rc1fuom/xWOqwL6fQU
         Wo5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmrN5cDY4PbcbfRYWswRpSN7yeSoqrT4A86SSRQGR9nhOBzjkzCuU8Y25VX5d0W7MvMWUtnpR85YE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPKsWl10qr++IoYB/0LqvSiVFzUZLzbJdOik4WlHLkD1vtNVHq
	wRLCVsdUP7XbaAnE6lGmq2gxNwD6tgUsFo8qiG5UAGQ23FHxnaZTgVnqb60gdfhEiSEpFGWOoqs
	O1iOURZlC1ck7fnlp6Rabhm41zBYs9LsVp2IQNDJ1
X-Gm-Gg: ASbGncuIprW519EgSQGI9e0u4nynoSqbboMKhVqP+LKxwLdaRAntfnuXV4OlieWpLr2
	CO1sNy0bVD28Ug9SDXzhLpQxoD5QQ4Z8YzG8KIp7bw1Aszd90fJ/S6DxVZSdUgOUrU+T+qwgHaK
	m18CI5Sgwyy3u7uOi2+pCglUnT2Vc9Z3HXLhJllmJU9yLmmuKa4Ylkr1YTX7d7OVt6MiTJ0jfmS
	4XS1uSZ1VOvDw==
X-Google-Smtp-Source: AGHT+IFhwGbrpihJuRhLUkMJwZwhp7F48vbVUtNc9cDlNYXnwMfD57uFUB1fnDEYXaM+LrUY65InbhFraP2uGeXjfLE=
X-Received: by 2002:a05:6102:290e:b0:518:9c6a:2c03 with SMTP id
 ada2fe7eead31-51a52a18e04mr12948137.30.1755625769614; Tue, 19 Aug 2025
 10:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com> <77qzhwwieggkmyguxm6v7dhpro2ez3nch6qelc2dd5lbdgp6hz@dnbfliagwpnv>
 <aJtYDWm3kT_Nz6Fd@google.com>
In-Reply-To: <aJtYDWm3kT_Nz6Fd@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 19 Aug 2025 10:48:57 -0700
X-Gm-Features: Ac12FXyvmYoSYuILjgZtuLq3eWcuEq7lOvEZt6VwwKRTWGTNC68lrUWFoa_zNzo
Message-ID: <CALzav=caCWiZ1oS05ZpPNcE1cVVmn8jk9xmbXsEF_Sqexq03JA@mail.gmail.com>
Subject: Re: [PATCH 00/33] vfio: Introduce selftests for VFIO
To: Joel Granados <joel.granados@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 8:04=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2025-08-05 05:08 PM, Joel Granados wrote:
> > On Fri, Jun 20, 2025 at 11:19:58PM +0000, David Matlack wrote:
> > > This series introduces VFIO selftests, located in
> > > tools/testing/selftests/vfio/.
> > Sorry for coming late to the party. Only recently got some cycles to go
> > through this. This seems very similar to what we are trying to do with
> > iommutests [3].

Joel and I synced offline. We decided the best path forward for now is
to proceed with VFIO selftests and iommutests in parallel, then look
for opportunities to share code once both have matured a bit.

