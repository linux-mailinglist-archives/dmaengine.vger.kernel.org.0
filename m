Return-Path: <dmaengine+bounces-6070-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABCDB2C9CD
	for <lists+dmaengine@lfdr.de>; Tue, 19 Aug 2025 18:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51E63B9415
	for <lists+dmaengine@lfdr.de>; Tue, 19 Aug 2025 16:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAFA26E16E;
	Tue, 19 Aug 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WvKIlnsK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E951425A352
	for <dmaengine@vger.kernel.org>; Tue, 19 Aug 2025 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621121; cv=none; b=Dmx+K+YQyd5aIgdcJKvsPIovibp6ucYYDBQEpeQZ2Q9yiIl49Aa+0iGe09ZOWmJNCqKCGpcxB8wTC1qNefIUqEH4hSQ7kqO+3cOKqBNKKRA0LdJDXKZyDjxggiRVwZ0nAHNlvSJFgJnDEI8OBWDPi/5RSTEQhqK6eWDxTAFmUhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621121; c=relaxed/simple;
	bh=cJyL4HFGFISuvEGZWUWistyHRtKUWIye98ZZtuZrwNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlgcPogKeZzP25igU9BC/U5SR7faJURKQU9l8W4GgVWjAQzls3Xg5n+kb1hxW+qvV62Z7hVdaCOeQ9T8zVUSYNQs0u7fcPdjWHJFz4Zxm4k1rdV9jqXftNaSXILyrcEwrUQnEnC+aMPt4pbt527kujdg3FfdZ2GtORs8RAy0MN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WvKIlnsK; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55ce526a25eso5485167e87.3
        for <dmaengine@vger.kernel.org>; Tue, 19 Aug 2025 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755621118; x=1756225918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uid2sLCe2fLbFbHk5A3JRr3795+bhaHijptEMore4t0=;
        b=WvKIlnsKDIffGsQDSkmbohpZGknofn6riVzl3zEzFv8NvPq2Z/vdF2b/wvXrV4RCwZ
         ooWTpRnS6qyCnzCfeMJXEnQMF8ri2TmRPvr3VL+/88IVSWQ9g5ri9vUxIp/9h/HXcvLg
         43EPHuWaeXIlCf7ie+9mzV45UMo6jkXO5mQ+rA3RE1GI8TaYzs3yqr+D0L2BKEhHpSIG
         tMSzsbJfoH0+db2cowunZ9Ci0uGIuGwGYbnA0f4sbCdtu9veWH25/xytpKMoZRFNWzgn
         yUhEGLqMm2fUGavjn2G8YOEpVB0FKMRpmjCfUHCEC6IOdeDy/6pS1+P10tO9pgv0JSWr
         K70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755621118; x=1756225918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uid2sLCe2fLbFbHk5A3JRr3795+bhaHijptEMore4t0=;
        b=n3fFUqHpCzZIFtzgqZRiPJX3wGakBhaQnpdpT2tUl63uSygVUfm+BI475zwUmUY0O2
         ikEufHfeUtE6NGbLCHQQtwBnVCr2cwnMyb2/M2pOJL2sbUv0M613GNV+7lfzDvVq5XPM
         8EKx84SUWBUgTPzd/Ygz40W3CfWiu+vwZ4UImJLEkHkiHDXCMx/c38Jtdc7E3XrqjhDp
         1iCGv9/SQGLsc2KmQEWez+V+2fF7xc9gcujKxmqXFO6T7SXwyx00jR3r6aUUObNgaHbG
         KKgdjzVfDQeN/PhFA2dEcWrlds8Jio+wMxKwqFGPoh9s46ekLutaY8YOBFUo08Zn9s3w
         OKtA==
X-Forwarded-Encrypted: i=1; AJvYcCXVLKLA4dexwwFz+3F6yom0+XQLSEPj2rSbGLPP508093ovX/zHjkuxksxT3In3Fhp1NKkViJXLlNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVsTU322BonF+LV08WkhWX5b4QKW9yXfl8r0DJJqO6P6m0AMoN
	sh1JoLQpBrVuE3LTGby8wh77YNX0rkwaF/3ecjCYW6joc9WIW1i1Q2QJoRTMcbKWzfl8Ll6k3x6
	Xzi0Gl6tNeXdfFvnARXEPDCSQJa2jBsb6p7n6hY29bNmq17hjbwO7+1lqNclsLA==
X-Gm-Gg: ASbGncuTkJzkb6J+rPypXvG+SZfDWEXAJgmMjRwlVmC9r6fb1HWdrR5ID2PNyeeZlwK
	P/4K0TF4F9zb1qK07w5imyBBfT0wrZ50GOEgpKbHq+xZJ5iPH9yn1s7O0Gtlf9FXOTAkA/upSxW
	n3DYXJlIJizxED3+8KYafE9pfUNjbFm97QLb87bFC434gvxI1OwYhW/ebnnqWLN0e9jengN82cf
	b+Emp6askWvTjK2m8tqz3SX
X-Google-Smtp-Source: AGHT+IG9LSQukP8L1OyXcAwDvQvV6AZS3ttTz4sGM7WhcvGtXa2X9Lc5cAjEjuGQBLz/JBJDdtyLVwih19LLEtI26SQ=
X-Received: by 2002:a05:6512:1287:b0:553:2c01:ff44 with SMTP id
 2adb3069b0e04-55e00756893mr851298e87.2.1755621117683; Tue, 19 Aug 2025
 09:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com> <20250620232031.2705638-23-dmatlack@google.com>
 <87a53w2o65.fsf@intel.com>
In-Reply-To: <87a53w2o65.fsf@intel.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 19 Aug 2025 09:31:30 -0700
X-Gm-Features: Ac12FXya_SwncPtupiaWHc47GwUOexOFH1Y3z4fRmAiEPe7hf7t_7YyPUGq3HJs
Message-ID: <CALzav=dPRfPxNAaVvbxSNz=Ss0DAGjxJQO2JnXLbZgwZmO0NBQ@mail.gmail.com>
Subject: Re: [PATCH 22/33] vfio: selftests: Add driver for Intel DSA
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vipin Sharma <vipinsh@google.com>, Wei Yang <richard.weiyang@gmail.com>, 
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 4:41=E2=80=AFPM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
> David Matlack <dmatlack@google.com> writes:
> > +
> > +static int dsa_probe(struct vfio_pci_device *device)
> > +{
> > +     if (!vfio_pci_device_match(device, PCI_VENDOR_ID_INTEL,
> > +                                PCI_DEVICE_ID_INTEL_DSA_SPR0))
>
> What are you thinking about adding support for multiple device ids?

I haven't given it much thought yet. But we could definitely support
fancier device matching (e.g. multiple acceptable device ids) if/when
a use-case for that arises.

> > +static int dsa_completion_wait(struct vfio_pci_device *device,
> > +                            struct dsa_completion_record *completion)
> > +{
> > +     u8 status;
> > +
> > +     for (;;) {
> > +             dsa_check_sw_err(device);
> > +
> > +             status =3D READ_ONCE(completion->status);
> > +             if (status)
> > +                     break;
> > +
> > +             usleep(1000);
>
> Another minor/thing to think about: using umonitor/umwait.

Thanks for the tip, I hadn't considered that. But I think for this
driver, keeping things as simple as possible is best. This code is
only used for testing so I don't think we care enough about efficiency
to justify using unmonitor/umwait here.

