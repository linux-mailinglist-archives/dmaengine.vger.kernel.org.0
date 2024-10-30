Return-Path: <dmaengine+bounces-3647-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED939B66E7
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 16:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20E31C217C6
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 15:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D9520ADF2;
	Wed, 30 Oct 2024 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b="qomTIikI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2009F200CA2;
	Wed, 30 Oct 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300611; cv=none; b=fSLnKluJDFy8cQ5uINPhoHsKjosiiOTeF6XdRmLU/BB5HZ7On6Tto8iPB2AXUMJizjICbB/tfMHL/a8XKleFweHtFz4876vlwDvxfH7QLFP6wg1tOvRaQi+WtJwBF3pR6F4d9bRXMcsoAoiv2tdtLxDBBByIiQBGZXf2516TNkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300611; c=relaxed/simple;
	bh=NAJDFpr9nmdU19C3JKcxMzbLsCujnceVqhZ/RKnEwwg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Af+TFKHbaNb+31NyYomIGXM73EbTT6cTqSu98SsoWPf9nOox0LZkrVYTYwFp+I+wNaLYmJk8frvjgX/RPZmzBKdUFVwnUGYm49zXP0bFaKHdfny3PyILmseqRbzytFLMMDTu/p8ax9QRp+1oc96YfhX0b314DFEoItACsgBOMu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b=qomTIikI; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730300534; x=1730905334; i=metux@gmx.de;
	bh=NAJDFpr9nmdU19C3JKcxMzbLsCujnceVqhZ/RKnEwwg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qomTIikI/OgfmxAbFKh1e8iCRJShu7EnlgU5G434TkB+7QieI60zcRnRQmNHY7mL
	 26XECiyiNu12zXTWRy2asSgHeF6VwbBHM3aDnQ3uox6d+N5j3vyz2V29nf9ZEHI/7
	 qUlSXTqxVipxXZ1JSehQTzpHDHQPSPiL/eaweFb8E7BUCEPOvfqCWNoLR7qjkN1j/
	 p49vWpG4avdBGfWZrfUUn1QQPJYBKupzAA27zZiM0BrIysUJtE3I4oi18t2KU2Jgp
	 NR5BKuTzLj4AssNq/jcoRi8JEym9/1eHXVRmJDUQ/Hacah+zbe10IoOhncuicwk4Q
	 B7fK/ijaayh5nLVM0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.178] ([77.2.112.201]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wPh-1tCUne2tcR-003w9y; Wed, 30
 Oct 2024 16:02:13 +0100
Message-ID: <0369c687-db33-4665-b3dc-143000ef2e47@gmx.de>
Date: Wed, 30 Oct 2024 16:02:48 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Maintainers now blocked from kernel.org mail access [WAS Re:
 linux: Goodbye from a Linux community volunteer]
From: metux <metux@gmx.de>
To: Hantong Chen <cxwdyx620@gmail.com>, tytso@mit.edu
Cc: ajhalaney@gmail.com, allenbh@gmail.com, andrew@lunn.ch,
 andriy.shevchenko@linux.intel.com, andy@kernel.org, arnd@arndb.de,
 bhelgaas@google.com, bp@alien8.de, broonie@kernel.org,
 cai.huoqing@linux.dev, dave.jiang@intel.com, davem@davemloft.net,
 dlemoal@kernel.org, dmaengine@vger.kernel.org, dushistov@mail.ru,
 fancer.lancer@gmail.com, geert@linux-m68k.org, gregkh@linuxfoundation.org,
 ink@jurassic.park.msu.ru, james.bottomley@hansenpartnership.com,
 jdmason@kudzu.us, jiaxun.yang@flygoat.com, keguang.zhang@gmail.com,
 kory.maincent@bootlin.com, krzk@kernel.org, kuba@kernel.org,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-spi@vger.kernel.org, linux@armlinux.org.uk, linux@roeck-us.net,
 manivannan.sadhasivam@linaro.org, netdev@vger.kernel.org,
 nikita.shubin@maquefel.me, nikita@trvn.ru, ntb@lists.linux.dev,
 olteanv@gmail.com, pabeni@redhat.com, paulburton@kernel.org,
 robh@kernel.org, s.shtylyov@omp.ru, sergio.paracuellos@gmail.com,
 shc_work@mail.ru, siyanteng@loongson.cn, tsbogend@alpha.franken.de,
 xeb@mail.ru, yoshihiro.shimoda.uh@renesas.com
References: <20241024173504.GN3204734@mit.edu>
 <20241024181917.1119-1-cxwdyx620@gmail.com>
 <e3559794-ab4a-48f2-8c28-52ef46258051@metux.net>
Content-Language: tl
In-Reply-To: <e3559794-ab4a-48f2-8c28-52ef46258051@metux.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jSWmplSFQgV90c2A0bkkvj2t8ExnIUMHHQD7NlbYYqtnVH71j/A
 Pj4uZIi6YPufmEMjudXa4dJHIygmTV1wIFJJkHGM+GIBFRAfnlev+sgkCZr+MF54lQRidxS
 bkG2HCXJq0essmv69s27h4WdycA0Rnb+4K1fnTHuD/qBR+mEDSBS53MElG91weJLYtaeg5k
 OTPFgaQ3fak8gIXNj4JDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WLKWUYisdM4=;2yNj/laS7SIY5FYvJFi4MhOmvxZ
 pHFbD0J1kye994bqbqLhdCTnBHW8Ug5JybvfzVUSlvhHAACTecoQE51xKKnV5hpKkUhCo8yLr
 /EvJ6VglOAgdSAY02WiKyUBPuOArNFiBamR/Fukdo2XJTgsXt550Q9Uu3s0mVOwxlXCMnWMns
 Fn7g+nMUVDwZg2peIk913PvjXMFh4d9Lkvh3kvC90QEiN4qogLfcOyB8IyykJPV3DQeeXp5hf
 +MrDjTpn28aqOi4W0rgu+IoyVD3neDdXwidld0Di4C2B0Xjeof79KSNCRhE6HCopzETXFL3/P
 Eq20+VJdDS4NGHO7dtKR96RqKlqckwmu3AywKAhNuZLL3xf4qG/GG7lFzucn1PmOwB9qzuDQ0
 T83E1gkoEctHd2TIp9iZslkwtRvZoLEaBVqlMchJ2WhOacIxu0B7j2GBH/lqButUW3kxkamyr
 QKLpEtwiYtP4mMfbOjHeKNuT587VBOcJ0soGtjcr5abLWdDOKEep1at+A6hNDrbBSP1f6/IBo
 BK+2+hzwJ3piZW/Yn1eaXBx6/3MBI0Lr+ftdHokUiS61Mp+GLxSd3NlP9E5Ud6tWQlNEOE+TO
 3A3+h1iPb9qNj+J4fjqMCG2p0nA6l58zMiSBfI4P0CjndwksOOuTcigJ6T1hzsfD+NMuWWKR6
 sAOmiaHvt7qnuiw6srIxEdbhvlRklDpq1Rv8Lrce6Ts8Z8qBYDnh7sqT0QOx+5KI9Lsu5iX3q
 5le4iVFFC4QhG4eqQ5l+1SnoJ0wgVAVlJ5k6YKhwZo8jzqS56dXAir9zu5tn+DGzJFsWUTgbd
 rbwM2pncFYXiGznL6foV5OhA==

Resending with another address, since the other one is
hard-blocked / censored by kernel.org mail server.

On 30.10.24 15:33, Enrico Weigelt, metux IT consult wrote:
> On 24.10.24 20:19, Hantong Chen wrote:
>
>> What LF and Linus done will inevitably create a climate of fear where
>> contributors and maintainers from the *Countries of Particular Concern*
>> feels endangered.
>
> And it's getting worse:
>
> They're now blocking mail traffic on kernel.org, even from maintainers.
> (my whole company is hard-marked as "spam"). Anything @kernel.org -
> lists as well as invidual inboxes.
>
> Still in the process of compiling evidence report. Anybody out there
> who's affected too, let me know - will be added to the report.
>
> I wonder when this one will be blocked, too. (I've still got many more
> left).
>
>> This is clearly NOT what contributors truly want. People from around
>> the world
>> once firmly believed that Linux was a free and open-source project.
>> However,
>> Greg's commit and Linus' response deeply disappoint them.
>
> Indeed. The trust that had been bulit up in decades is now finally
> destroyed - just by a few mails.
>
> Linux has been turned into POSS, politware.
>
>> Open-source projects might be international, but the people or
>> organizations
>> controlling them are not. This is the source of concern and
>> disappointment.
>
> That's why those projects should never depend on just a few individuals
> or organisations in one specific country.
>
>
>
> --mtx
>

