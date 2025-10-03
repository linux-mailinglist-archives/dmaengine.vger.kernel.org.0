Return-Path: <dmaengine+bounces-6761-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06778BB797A
	for <lists+dmaengine@lfdr.de>; Fri, 03 Oct 2025 18:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EADA54E89EA
	for <lists+dmaengine@lfdr.de>; Fri,  3 Oct 2025 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA232D061A;
	Fri,  3 Oct 2025 16:45:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B34D1DFDE;
	Fri,  3 Oct 2025 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509921; cv=none; b=TwkH4dAC9BpLJkQaPOClDNtnDPLuidxrEzjP+9sQnlXmK8S4ojKsMAtPwmi5ejPcCTsVZsvzTqAHfqZJINbRKdaYJODnql6viCC8qmZpzjS06/kJvqTt12UKEHtb4roJYd6vSKG4vhhPIz1NvLiL2zfOhA213cyatRYE1P+fUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509921; c=relaxed/simple;
	bh=dssgCzltttWWVbtDuxXyHlgcBj3U4zXAPU0QQmfapf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EE/zFoBMAYWKX9ARW0jzbFqr9yIaTAtvCWUiJ/upGfzMH7/57oVz7jfF0RKaK1spqTVF/Es7ttmryZ440GJU5FIQH/kehXIRL4oum+OMDN3/JHjfHk/JuLpUk8noREr1PHOw3fqIs/44fkBQPmWdtzykhS/fpfd8wzbaWuVjtXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 5C5AC72C8CC;
	Fri,  3 Oct 2025 19:45:11 +0300 (MSK)
Received: by imap.altlinux.org (Postfix, from userid 705)
	id 4F2B736D070F; Fri,  3 Oct 2025 19:45:11 +0300 (MSK)
Date: Fri, 3 Oct 2025 19:45:11 +0300
From: Michael Shigorin <mike@altlinux.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Michael Shigorin <mike@altlinux.ru>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tor Vic <torvic9@mailbox.org>, Kexy Biscuit <kexybiscuit@aosc.io>,
	jeffbai@aosc.io, gregkh@linuxfoundation.org, wangyuli@uniontech.com,
	aospan@netup.ru, conor.dooley@microchip.com,
	ddrokosov@sberdevices.ru, dmaengine@vger.kernel.org,
	dushistov@mail.ru, fancer.lancer@gmail.com, geert@linux-m68k.org,
	hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	mattst88@gmail.com, netdev@vger.kernel.org, nikita@trvn.ru,
	ntb@lists.linux.dev, patches@lists.linux.dev,
	richard.henderson@linaro.org, s.shtylyov@omp.ru, serjk@netup.ru,
	shc_work@mail.ru, tsbogend@alpha.franken.de, v.georgiev@metrotek.ru,
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Subject: Re: what about CoC?
Message-ID: <20251003164511.GK7291@imap.altlinux.org>
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io>
 <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org>
 <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
 <20241024095339.GA32487@imap.altlinux.org>
 <20251001101148.GA30625@imap.altlinux.org>
 <87371abc-e43f-4afb-83d0-b9a04fc015c0@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87371abc-e43f-4afb-83d0-b9a04fc015c0@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Oct 03, 2025 at 05:48:40PM +0200, Alexander Lobakin wrote:
> It's about companies that sponsor the war or are a part of it.

So ban Intel.

-- 
Michael Shigorin
...хотя вырусь не поймёт даже почему

