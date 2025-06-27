Return-Path: <dmaengine+bounces-5651-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA09EAEAF66
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 08:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD695664BC
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 06:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7198421858D;
	Fri, 27 Jun 2025 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UegOdAV/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3265821772D;
	Fri, 27 Jun 2025 06:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007468; cv=none; b=N0lLh+TMqtEn7IiJfGLiDeg7wSWRtYSwVU1bBtSP1bjJRlQLpVmbK2o2OJetxS3fa2atU10aaU36zUmxwevliX+4RhkqnIto3WwdDmYRK48CVQDFXt02Y1Ibm1oI7HEGpS5lhD/gY8gpEUxLy1kEd5YUCYuwT7Q5PB+mI9eUQjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007468; c=relaxed/simple;
	bh=Uo4olL5yDw0YFadlO02NXTHa38+zQf05vr91IvJyStY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiF9RLnj0btB0ZNJ9MXizVRo9zEwman7nG02be/LXLETFK5krzl9BdCX37sZq9Ik/ImGaUC3+6O52GbTAppwwRuPXlNDsGMXnTMRcEuo8yVapRiAeBf1jbWlVuHc5UDiTrmpqw/XdZL89suwyInV4kfMmX2YgxBVTr+QPjFiR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UegOdAV/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acb5ec407b1so314972666b.1;
        Thu, 26 Jun 2025 23:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751007464; x=1751612264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4eds/rIFq5zfoX/63Svgj/d7xGIUzwYOHndRisqlgQ=;
        b=UegOdAV/OeQzs2NlpRfgit54yD3qmDqLUfGPlGV38BLg336iljLWmtaJ/WXbS9A60G
         x/+rTHkXo6QrNOyd+draerBE3np7oJDS981qghwuYTD4ArzXk+ZQeTlB0ak9ZOL0U0zV
         a7ZtBPHT6g3sZeIKb/+GnTsurDslsAq0T9up4XUi8k5C7jq32PtnPlmNy/Vo4abJo9hf
         K6a5CoXByxbJ4pbOdX7y/KhZzPLS05aOZ1JjJgtcwf3W0U0LwUrdpYCa1CyHAXrvBaRc
         iMUtPgBM7u/KaDCaL+YrPQfE4X6YcAXjUJBRa6ZpU57daJmXnqZW3v7Ztkg8Iao3Qqw2
         7wSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751007464; x=1751612264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4eds/rIFq5zfoX/63Svgj/d7xGIUzwYOHndRisqlgQ=;
        b=HrxgBUcCu6pe6T/ohscZNK+Ge6fZnE+PqZoruvsK9Ks/K4A1jZves4+K9IH1F5eyMB
         AncbLRUpqTkdtt5hJ+JNogpnzeZbVHaqTnO9OdUxFBLbrF2xYx8eN/rSMfUhELXIo2KV
         ehcbQx9TRcIe1WZ1VZBRnxmq/j193/5XJXKlCDZnCIqb00H5GAdrXFSVkj3Hh+76Lq/e
         pNlBzx8JJ7y5uFFbmsuoGnx6iDmMzifb5+RaLeBeUNJ0K2TOrcO7xlYnQKLMpiS8Oe32
         8ezdrtndCpCztNSRsnr5uHRuOiw/lfv8P4V5ArrQYlOtdMw5whoXoDMlEiHgaSXgbGbR
         HnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxlisPyfaqrSFX8EKDdpXX8KUmbBKl27xEwj89fTpoZxdwvNxy+OqcfXe+ajvyiN0O4K8GHSVArUnWYGz7@vger.kernel.org, AJvYcCXQiMPYuRKit7WDUK8+NU8Xw4win9740bE4ExEtLpj+qtQDRDpYtqnT3nPQnkkTR5yDENApbziNmng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ+rvLcvwCVK4mWYS8iyBQzaEH/wNWY6Ya1w5zxzYCwbGsv1LU
	OqhcHE9ZN2JkLsdMjYs4DYDVPsThkpCMAm+5rIFjjGYmy1HLgWvbVTmcMnv42wqMW3W+qrW5F+d
	rYZ7b3O/GAot/qVYodqWsgvV6HmgIoGg=
X-Gm-Gg: ASbGncvSc81TJbl3eJ2P2HMAa3Nh3mG2X5tdI0py9Tdv0JikYfIy0THDTjQCQcfFZHx
	YHxBY86+vI8cnYJurr9f4zHlxxcZic/XHhV9Ka/aGFiq86rETgVbsoXrkTIn/+1E7RyyuktJsFW
	8DEYoK3UMyPS4qYeuq84InWAJFOVsDWEGFge/O06Z5BVMXMQ==
X-Google-Smtp-Source: AGHT+IHJSsyMeqRr5intkwBWnKyNtk3g0mX7tSg7DFc2b0s9uH+82/Y88uv28Rky7EHgItkJ470zIsHiOfZBX18e8pM=
X-Received: by 2002:a17:906:c154:b0:adb:229f:6b71 with SMTP id
 a640c23a62f3a-ae34fce7aaemr184521966b.5.1751007464308; Thu, 26 Jun 2025
 23:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404053614.3096769-1-yi.sun@intel.com> <175097809157.79884.15067500318866840512.b4-ty@kernel.org>
 <aF4YdFZnAWcZlpbW@surfacebook.localdomain> <aF46cRgzYE4N3A25@ysun46-mobl.ccr.corp.intel.com>
In-Reply-To: <aF46cRgzYE4N3A25@ysun46-mobl.ccr.corp.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 27 Jun 2025 09:57:07 +0300
X-Gm-Features: Ac12FXz2y3A_ioqrN6rCHgk48H91jo-Ky6pl0Onf28Kg7scL2GJHNLk-quO9dO8
Message-ID: <CAHp75VciZKX8uyZvYsrG6-ffrZbzDEPU4UH06eh9X23qBC0LYg@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: idxd: Remove __packed from structures
To: Yi Sun <yi.sun@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gordon.jin@intel.com, yi.sun@linux.intel.com, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Fenghua Yu <fenghuay@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 9:30=E2=80=AFAM Yi Sun <yi.sun@intel.com> wrote:
>
> On 27.06.2025 07:05, Andy Shevchenko wrote:
> >Thu, Jun 26, 2025 at 03:48:11PM -0700, Vinod Koul kirjoitti:
> >>
> >> On Fri, 04 Apr 2025 13:36:14 +0800, Yi Sun wrote:
> >> > The __packed attribute introduces potential unaligned memory accesse=
s
> >> > and endianness portability issues. Instead of relying on compiler-sp=
ecific
> >> > packing, it's much better to explicitly fill structure gaps using pa=
dding
> >> > fields, ensuring natural alignment.
> >> >
> >> > Since all previously __packed structures already enforce proper alig=
nment
> >> > through manual padding, the __packed qualifiers are unnecessary and =
can be
> >> > safely removed.
> >
> >[...]
> >
> >> Applied, thanks!
> >
> >Please, don't or fix it ASAP. This patch is broken in the formal things,
> >i.e. changelog entry must not disrupt SoB chain. I'm not sure if Stephen=
's
> >scripts will catch this up on Linux Next integration, though.
> >
> >--
> >With Best Regards,
> >Andy Shevchenko
> >
> >
>
> Hi Andy
>
>  From what I understand, changelog comments are ignored by git am and do =
not
> interfere with the SoB chain. They appear after the "---" separator and
> aren't part of the actual commit message. So it should be safe and won't
> break anything during the integration.
>
> Let me know if there's something I might have missed.

Please, look how it looks in the repository:
https://web.git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/com=
mit/?id=3D671a654aecc710a278bdd30cfd2afef2d4e0828f
This is wrong.


--=20
With Best Regards,
Andy Shevchenko

