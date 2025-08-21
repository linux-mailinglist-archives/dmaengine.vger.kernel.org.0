Return-Path: <dmaengine+bounces-6102-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D57DB3057E
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 22:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891971CE77B0
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 20:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A7D2C0266;
	Thu, 21 Aug 2025 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPQBrMwr"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EF32C0264
	for <dmaengine@vger.kernel.org>; Thu, 21 Aug 2025 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807059; cv=none; b=CExNkDc6NaWwZw+f+Ybzu5mEqrGlCT+Pm4G/p9iLHcBJ9kqI6+JCPGR2lCHfLxICCY8cBc7HQv2xEXVt/RkmuUi+tvxv35LATIArgYctAaNtTn4OtR+yDZaIYyd64iOXiqV2GD17nLX/r7uTDqZ7j3FumJ1vF4pXlGUPxAoeR+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807059; c=relaxed/simple;
	bh=R0ZyW/lP53DUpD5XCfGL8s/RHhsGuoWDmk/SVEPPWc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhIaINFvhniVhyyF1sojs6uDhXEXlqrB729tgGi/VwPuSaEthYafcae8SkB8WvWkdM0xF+r62W4uIw5zs60PfEf/CnvvP55s9k7PdpAfSemUYfvKpi2F5nOHp0EbZDwEJ1mG3ov9KCzHuFHVDdiIq7UaSefPpy2fZQ6/OqIWH9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPQBrMwr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755807056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=An+3TCbux96ebWXl79jkDvpeTXFUup6Liv8QO7JiiR4=;
	b=fPQBrMwrJVXRHkUpnENb5BlogZskwxxagTyy0XHa6Le5T7B8lPoB+SLNhuJVfHRDhs83vX
	UBa4p/q7G+1lylem7u5ePzgbfiaqoyixRKhQIosUZOMdpzHV6MV4zQhGjbueSXyZeyUaFF
	/ibtmYIVQOHHvhJgdBf7ni0cIgT4Htk=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-HF0dlqerMdG7eizbLElG3w-1; Thu, 21 Aug 2025 16:10:55 -0400
X-MC-Unique: HF0dlqerMdG7eizbLElG3w-1
X-Mimecast-MFC-AGG-ID: HF0dlqerMdG7eizbLElG3w_1755807055
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e6804691a2so3434985ab.0
        for <dmaengine@vger.kernel.org>; Thu, 21 Aug 2025 13:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807055; x=1756411855;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=An+3TCbux96ebWXl79jkDvpeTXFUup6Liv8QO7JiiR4=;
        b=kvlBh3F4tWacO73zPFCZcPtyag1iohyfrBq6wDZD5m9UJKPkoowqUEZU49V3jVmBWP
         XfZmvMxc286nnSeldBHG6F+2J+4D9Edz73vbiucEcyNbHh08Qky4OykusZua6unLduGa
         z11AAnUFdNqEKwljPISYeljmJAmfXxg2tfyh3fK8EiEeTP1iBJrBlwt+9N6A/2cKuUif
         tzp3IE0yPXOPH9jS+esaxu0F6fVc1qYKCiRUwX1FqlZOlmEdUPjVl6paswmnJxFL90Cu
         xAQWCvG5IhMxshe6GxS5emFmMx+zlu18b89DZQKdpyYF/TWVU5vHpqIoYL3U80F4x0JB
         D+vg==
X-Forwarded-Encrypted: i=1; AJvYcCWaYeVgvyUvSPM/0ZouIbq9lqzD/5LYuR/r02OFVGXTcWa+Banx3iWGOwfWnq+0uOzsHZ8G/rXg+28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDGoeJB2ewgshcqiiU603vr4HO5ciLXvI2axMh86AGTUR1cMUK
	CAhfJ1X0YfdZQXdtbSMvIfIEFDaMxrYv6AZ85w3tdVSQeCeYXX/oASbHKZUOkaZclZL7KSpVhF1
	WnmaP4QVh234vFAjwEHEA1/w0rkB8wYfXA67L3zgAPMWSZXoYK3FM7b688I0ZOQ==
X-Gm-Gg: ASbGncvs3gbzc8FNRWWlVhDL+T/H3IhOgfJ/ucB0S9WLKpKroqPh318rM51I+5MnAHn
	MWJaLGuLxQ9gAw08Mtn0C8tfz3XFMRfDHbjMNta2yqK5jPQ2ccs509DG8jlWq/VKkMMJuVcBkoZ
	e5DOUnU2P9Huc3+qBDWpBH3YO3Db+rJzJw+A0RrrHexVYBDCireSBXmU0As3nQudfUdeqBQpnPG
	QXYnS1APTRzkvb8LUPkfWYCRCc4pCTNk7Y1XOEAtPmHKRFAbvQWY6szRzmylZJ7sJzsPX8JcB97
	TZc9rivOL204SNuGIrUP3VLd6cuuxtdoZVPKdLEtGK0=
X-Received: by 2002:a05:6602:6407:b0:881:982b:9946 with SMTP id ca18e2360f4ac-886bd0f1ad1mr31883539f.1.1755807054517;
        Thu, 21 Aug 2025 13:10:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7UyEEHnmghSQL6lcVlKCttefDYrWN/3zEcgegYm6NRgpa88y8amc0JBLXw47xKtjo5rcPAA==
X-Received: by 2002:a05:6602:6407:b0:881:982b:9946 with SMTP id ca18e2360f4ac-886bd0f1ad1mr31879039f.1.1755807053992;
        Thu, 21 Aug 2025 13:10:53 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8843f9c3329sm702744239f.19.2025.08.21.13.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:10:53 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:10:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Aaron Lewis <aaronlewis@google.com>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>, Adithya Jayachandran
 <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, Ard
 Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 dmaengine@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, James
 Houghton <jthoughton@google.com>, Joel Granados <joel.granados@kernel.org>,
 Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, "Mike Rapoport
 (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat"
 <prsampat@amd.com>, Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson
 <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, Wei Yang
 <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Subject: Re: [PATCH 00/33] vfio: Introduce selftests for VFIO
Message-ID: <20250821141048.6e16e546.alex.williamson@redhat.com>
In-Reply-To: <CALzav=eOz+Gf8XawvaSSBHj=8gQg3O9T9dJcN6q4eqh7_MEPDw@mail.gmail.com>
References: <20250620232031.2705638-1-dmatlack@google.com>
	<CALzav=dVYqS8oQNbygVjgA69EQMBBP4CyzydyUoAjnN2mb_yUQ@mail.gmail.com>
	<20250728102737.5b51e9da.alex.williamson@redhat.com>
	<20250729222635.GU36037@nvidia.com>
	<CALzav=d0vPMw26f-vzCJnjRFL+Uc6sObihqJ0jnJRpi-SxtSSw@mail.gmail.com>
	<CALzav=fdT+NJDO+jWyty+tKqxqum4RVkHZmUocz4MDQkPgG4Bg@mail.gmail.com>
	<20250818133721.32b660e3.alex.williamson@redhat.com>
	<CALzav=eOz+Gf8XawvaSSBHj=8gQg3O9T9dJcN6q4eqh7_MEPDw@mail.gmail.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Aug 2025 13:33:52 -0700
David Matlack <dmatlack@google.com> wrote:

> On Mon, Aug 18, 2025 at 12:37=E2=80=AFPM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > On Mon, 18 Aug 2025 11:59:39 -0700
> > David Matlack <dmatlack@google.com> wrote:
> > =20
> > > On Thu, Jul 31, 2025 at 1:55=E2=80=AFPM David Matlack <dmatlack@googl=
e.com> wrote: =20
> > > >
> > > > On Tue, Jul 29, 2025 at 3:26=E2=80=AFPM Jason Gunthorpe <jgg@nvidia=
.com> wrote: =20
> > > > >
> > > > > On Mon, Jul 28, 2025 at 10:27:37AM -0600, Alex Williamson wrote: =
=20
> > > > > > On Fri, 25 Jul 2025 09:47:48 -0700
> > > > > > David Matlack <dmatlack@google.com> wrote: =20
> > > > > > > I also was curious about your thoughts on maintenance of VFIO
> > > > > > > selftests, since I don't think we discussed that in the RFC. =
I am
> > > > > > > happy to help maintain VFIO selftests in whatever way makes t=
he most
> > > > > > > sense. For now I added tools/testing/selftests/vfio under the
> > > > > > > top-level VFIO section in MAINTAINERS (so you would be the ma=
intainer)
> > > > > > > and then also added a separate section for VFIO selftests wit=
h myself
> > > > > > > as a Reviewer (see PATCH 01). Reviewer felt like a better cho=
ice than
> > > > > > > Maintainer for myself since I am new to VFIO upstream (I've p=
rimarily
> > > > > > > worked on KVM in the past). =20
> > > > > >
> > > > > > Hi David,
> > > > > >
> > > > > > There's a lot of potential here and I'd like to see it proceed.=
 =20
> > > > >
> > > > > +1 too, I really lack time at the moment to do much with this but=
 I'm
> > > > > half inclined to suggest Alex should say it should be merged in 6
> > > > > weeks (to motivate any reviewing) and we can continue to work on =
it
> > > > > in-tree.
> > > > >
> > > > > As they are self tests I think there is alot more value in having=
 the
> > > > > tests than having perfect tests. =20
> > > >
> > > > They have been quite useful already within Google. Internally we ha=
ve
> > > > something almost identical to the RFC and have been using that for
> > > > testing our 6.6-based kernel continuously since March. Already they
> > > > have caught one (self-inflicted) regression where 1GiB HugeTLB pages
> > > > started getting mapped with 2MiB mappings in the IOMMU, and have be=
en
> > > > very helpful with new development (e.g. Aaron's work, and Live Upda=
te
> > > > support).
> > > >
> > > > So I agree, it's probably net positive to merge early and then iter=
ate
> > > > in-tree. Especially since these are only tests and not e.g.
> > > > load-bearing kernel code (although I still want to hold a high bar =
for
> > > > the selftests code).
> > > >
> > > > The only patches to hold off merging would be 31-33, since those
> > > > should probably go through the KVM tree? And of course we need Acks
> > > > for the drivers/dma/{ioat,idxd} changes, but the changes there are
> > > > pretty minor. =20
> > >
> > > Alex, how would you like to proceed? =20
> >
> > I think we need an ack from Shuah for the overall inclusion in
> > tools/testing/selftests/
> >
> > AFAICT the tools include files don't seem to have any central
> > authority, so maybe we just need to chase those ioat/idxd acks, along
> > with Shuah's and we can get this rolling and follow-up with the latter
> > KVM patches once the base is merged.  Thanks, =20
>=20
> Sounds good.
>=20
> And yeah, I also don't see any maintainers listed for tools/include/
> or tools/arch/x86/include/. Jason left some comments on the RFC that
> reduced the delta in v1, but that's the only feedback I've gotten so
> far there.
>=20
> I will try emailing Shuah and the ioat/idxd maintainers directly as a
> next step, since it has been about 2 months since I posted this series
> and we haven't heard anything yet.
>=20
> Thanks for the help.

I think we have all the required acks now and reviews just suggest some
minor patch shuffling, right?.  You were also going to switch from
reviewer to maintainer of the selftests in MAINTAINERS ;)

Are you planning to collect those acks, add the minor changes, drop the
trailing KVM changes to come in through the existing kvm selftests and
repost?

With KVM Forum coming up, I'd like to try to get this squared away and
into the vfio next branch by next week.  Thanks,

Alex


