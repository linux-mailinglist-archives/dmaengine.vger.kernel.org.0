Return-Path: <dmaengine+bounces-5877-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8864BB14044
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jul 2025 18:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4D23B2003
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jul 2025 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C1D1A254E;
	Mon, 28 Jul 2025 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d46dmfnh"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F52A25E44D
	for <dmaengine@vger.kernel.org>; Mon, 28 Jul 2025 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720066; cv=none; b=hmYZEcTopRCqS8ze61EegcGv+9V0FDqhPEZpV49ioteJxT6xoJ1fKeLiHDmZhdyts5fABiClGUWUs+McngaMUyxGFyKvXK77rTp8CZIfzHDqPL46A2Xb2vnWyW3UwzalYGeb979d4rG20tL/XrCDvM7YQ3/F3ZDKOiF7/1jC6XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720066; c=relaxed/simple;
	bh=Ya45jQPXHk2oP2X0G+LpFes59f3rujaPubzq7KF+/kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLbIRdA9OvKOvt+NE8DgBDzOKwSRZ0uKGsrtUezaiut6fZpXSZby+Tcx2gNYargH4/uRJ5Shp7boY4NIlefHFsd2yB5NxSTKBwrljCyyOHROw61cXnLSp+M8ySefK1KcWJ7A6tRk3RbCroskXIhVc7M1wOrGRzate2Vp0UwBmkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d46dmfnh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753720064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xArcZSjUcc0JM++Nvf69XtSLwcuglbrEMCVCa+W7/Rs=;
	b=d46dmfnhEguArYNbxDa1KzQffGKugeKnZl/NrbQZfqxAh0tVUiWzUZgggYypmOoxrrNKAk
	zkk1VphMe5Tx8StNDNHAC+DYpwOHQukLanGTDS8vpTM0WZ7sdFfWQaczbboa+RXF69NYnT
	JbeNhZ02M1NiWDyKuXGa6VhAlbWtxMs=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-Y_iivpYcPZuiER2w_jDzgw-1; Mon, 28 Jul 2025 12:27:41 -0400
X-MC-Unique: Y_iivpYcPZuiER2w_jDzgw-1
X-Mimecast-MFC-AGG-ID: Y_iivpYcPZuiER2w_jDzgw_1753720061
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88118bfccf4so23361439f.2
        for <dmaengine@vger.kernel.org>; Mon, 28 Jul 2025 09:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753720060; x=1754324860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xArcZSjUcc0JM++Nvf69XtSLwcuglbrEMCVCa+W7/Rs=;
        b=kcKKAlJ3T6OtX5gP83eotYzRcjDIRBbOHTmtEDyAszEthDjea32uOJ8tL15trALnXs
         9xRRTSBvjTp61fjAT5JjgJSBxbZ6XQ1DHRisSqi29Q2YpwqUOuVVyJvXsKJVJ1Lqteu4
         zLl+UstHGDSSLWJ823AOvuUsZORJcXK0ugQCLMkXY2+ygXkks1QO9/AFlG+sY0f9aiYu
         cYCvm83nw/L6BLJiv86ZxR0PI8rNDrycKbvFJt9c9IvFaQBD5yTTHNzQASsZ0RIR8+6D
         MiPPJGk3DInibcOBJlqVKupFJObF8nz71CBPR9kpJ8dHcTeQQmdqZlQ7jitVsCUwYD6y
         CYjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtMEDPjUbkUZZVMqTCPH0XVylaoBVuRLlW9by5TqGmic3oj+xy9jDC/wUIubp9NmK0rZmwPSGv5PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwE01LxfYDRi4TL95845yl+XImbkpqWTWrTxmnNpDvsYb0GI9D
	oL2N7SpwzsELEsxP3ut48d/Qf99dOzgNrdIVlyds3Ihby4RsN/E1QRVv1L+ysAD06Ot6uNk9hhP
	lA0gK6VuQEQL+vnL7U02MNZI4WqhdZ5c61LXnOq7mJzTNImxWx46cHmdkIseZBA==
X-Gm-Gg: ASbGncueGskBMIUe46FF1UZhz3PlGh9GH37VDX8kga+UB+XD8n/zsEWuj8mpQgacr45
	xqwr2+65lgxhkOf30lzpjCDfKWyd3h9pRZq94K7BfV6cpNaV3SIoYNVfzCF2qI3zVfp0meS8V7g
	iHOw09gNbPvstzlcmBy3pL9WmhZsf+YWdWndL5ydu0R9cwd1qEqxtqIYLBR3B1a3lDH/MGLJPyM
	WffLVoIVucfQdmkDSG0iXA6msUFcu8dta8K4gzwMha9CzHKs0hFInpJnAPgx2LYNnOZwuKd+elA
	LdK1ubojkB4n2jJT8kBZpUKvx+kz3B1Ngwnny+bBVgc=
X-Received: by 2002:a05:6e02:1809:b0:3e2:c6a3:aa75 with SMTP id e9e14a558f8ab-3e3c5378324mr58629245ab.6.1753720060566;
        Mon, 28 Jul 2025 09:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpe+ugGAmXF2USuwRkLE9+KI7pOiQNBqc2vtbrZJCicQ1Wplt9KVvxUosu4y3uaaNZ0wXR2Q==
X-Received: by 2002:a05:6e02:1809:b0:3e2:c6a3:aa75 with SMTP id e9e14a558f8ab-3e3c5378324mr58628985ab.6.1753720060073;
        Mon, 28 Jul 2025 09:27:40 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508c9223199sm1944955173.51.2025.07.28.09.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 09:27:39 -0700 (PDT)
Date: Mon, 28 Jul 2025 10:27:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Matlack <dmatlack@google.com>
Cc: Aaron Lewis <aaronlewis@google.com>, Adhemerval Zanella
 <adhemerval.zanella@linaro.org>, Adithya Jayachandran
 <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, Ard
 Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 dmaengine@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, James
 Houghton <jthoughton@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Joel
 Granados <joel.granados@kernel.org>, Josh Hilke <jrhilke@google.com>, Kevin
 Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "Mike Rapoport (Microsoft)"
 <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, Wei Yang
 <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Subject: Re: [PATCH 00/33] vfio: Introduce selftests for VFIO
Message-ID: <20250728102737.5b51e9da.alex.williamson@redhat.com>
In-Reply-To: <CALzav=dVYqS8oQNbygVjgA69EQMBBP4CyzydyUoAjnN2mb_yUQ@mail.gmail.com>
References: <20250620232031.2705638-1-dmatlack@google.com>
	<CALzav=dVYqS8oQNbygVjgA69EQMBBP4CyzydyUoAjnN2mb_yUQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Jul 2025 09:47:48 -0700
David Matlack <dmatlack@google.com> wrote:

> On Fri, Jun 20, 2025 at 4:21=E2=80=AFPM David Matlack <dmatlack@google.co=
m> wrote:
> >
> > This series introduces VFIO selftests, located in
> > tools/testing/selftests/vfio/. =20
>=20
> Hi Alex,
>=20
> I wanted to discuss how you would like to proceed with this series.
>=20
> The series is quite large, so one thing I was wondering is if you
> think it should be split up into separate series to make it easier to
> review and merge. Something like this:
>=20
>  - Patches 01-08 + 30 (VFIO selftests library, some basic tests, and run =
script)
>  - Patches 09-22 (driver framework)
>  - Patches 23-28 (iommufd support)
>  - Patches 31-33 (integration with KVM selftests)
>=20
> I also was curious about your thoughts on maintenance of VFIO
> selftests, since I don't think we discussed that in the RFC. I am
> happy to help maintain VFIO selftests in whatever way makes the most
> sense. For now I added tools/testing/selftests/vfio under the
> top-level VFIO section in MAINTAINERS (so you would be the maintainer)
> and then also added a separate section for VFIO selftests with myself
> as a Reviewer (see PATCH 01). Reviewer felt like a better choice than
> Maintainer for myself since I am new to VFIO upstream (I've primarily
> worked on KVM in the past).

Hi David,

There's a lot of potential here and I'd like to see it proceed.  I've
got various unit tests that we could incorporate over time and
obviously picking up Aaron's latency would be useful as well.

Something that we should continue to try to improve is the automation.
These tests are often targeting a specific feature, so matching a
device to a unit test becomes a barrier to automated runs.  I wonder if
we might be able to reach a point where the test runner can select
appropriate devices from a pool of devices specified via environment
variables.

An incremental approach like you're suggesting is usually the best
course.  Implement the framework and something basic, then build on it.
30+ patches is a bit much to chew on initially.

Your recommendation for MAINTAINERS sounds good to me.  I'm not too
familiar with the selftests, so I'll clearly be looking for your input
once we've established the initial code.  Thanks,

Alex


