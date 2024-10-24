Return-Path: <dmaengine+bounces-3496-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4EA9AEF41
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A247FB23C4B
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 18:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C4D1FF7D9;
	Thu, 24 Oct 2024 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=notyourfox.coffee header.i=@notyourfox.coffee header.b="JHSUzjKl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.notyourfox.coffee (mail.notyourfox.coffee [92.63.193.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68331FC7F6;
	Thu, 24 Oct 2024 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.63.193.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793454; cv=none; b=jvbsQZLXfGJUShLlZpRBJplMyAnli7Pn1xPZzLSddIz9qtwwAFVv5/5jXyCeH7WCWcp8GsYv0sG4VQCIvyo/LKiAcG5ikNKThq2ypSf0UmC5gh2CWQ9W+wmzujJgbvD8NLtyWx3oN44nBJlayLB7muNC0KlzFFOxuePzDOFKRfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793454; c=relaxed/simple;
	bh=4HaM2tprLpARFSOFiAD1IewWveAq50xA4izcD+Ol1hg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=F/19doZ4IYXXulnHQ4taEYkLYGFE63YNrEi2RX0OKR72gmYEnSQVs+p2GJ8QkwGLlYRR0C2iF02XxpMyqge8fU+SkvG7afPqCQTm94mrIGc1+forNCtUer098veSHlzfPHEZlbtNZyJvQb61kjdbFKiHO8hTuZm4xQzhtgT9dxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=notyourfox.coffee; spf=pass smtp.mailfrom=notyourfox.coffee; dkim=pass (2048-bit key) header.d=notyourfox.coffee header.i=@notyourfox.coffee header.b=JHSUzjKl; arc=none smtp.client-ip=92.63.193.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=notyourfox.coffee
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=notyourfox.coffee
DKIM-Signature: a=rsa-sha256; bh=zD/MvoTUjjchDlHO31PqaPi5FVCTTnWec43Dr2sc5uE=;
 c=relaxed/relaxed; d=notyourfox.coffee;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@notyourfox.coffee; s=mail; t=1729793394; v=1; x=1730225394;
 b=JHSUzjKls5Wm839qvhA6nxJdgjfFHYyuIMcFJC4py2Th5/lRpBJL87itZiTg0D7g72byla2/
 RGt9j0YQZcrrSnTMUigTkonLFjKQ1wty2LN+88I2MCPC3PFacLmQ6qZhW6CFbZFxlrquYkL2uWA
 8n/E59Ut+LmSKvFcVYkl9wkkdRh8MLTO73De9KCAPILQIWuDQToZmui76W//DdF1v3lfmvIwrLC
 00BhABRp1gebdHeZoI70ehEYTqlEw8KiEoYc1vSAp1tKTck0QShQZ9gBb/1Ia55r4kKsUVkpN30
 gJICGzIIOhLel8x+rFvTjeBr9jYMQEnr6fmrnHA+6Rz6Q==
Received: by mail.notyourfox.coffee (envelope-sender
 <contact@notyourfox.coffee>) with ESMTPS id 1345da47; Thu, 24 Oct 2024
 18:09:54 +0000
Message-ID: <c58172db-e3cc-488d-baa6-f095588a8771@notyourfox.coffee>
Date: Thu, 24 Oct 2024 21:09:52 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vladimir_putin_rus@kremlin.ru
Cc: aospan@netup.ru, conor.dooley@microchip.com, ddrokosov@sberdevices.ru,
 dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com,
 geert@linux-m68k.org, gregkh@linuxfoundation.org,
 hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru, jeffbai@aosc.io,
 kexybiscuit@aosc.io, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org,
 mattst88@gmail.com, netdev@vger.kernel.org, nikita@trvn.ru,
 ntb@lists.linux.dev, patches@lists.linux.dev, richard.henderson@linaro.org,
 s.shtylyov@omp.ru, serjk@netup.ru, shc_work@mail.ru,
 torvalds@linux-foundation.org, torvic9@mailbox.org,
 tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, wangyuli@uniontech.com,
 wsa+renesas@sang-engineering.com, xeb@mail.ru
References: <20241024140353.384881-1-vladimir_putin_rus@kremlin.ru>
Subject: Re: [PATCH 0/2] MAINTAINERS: Remove few Chinese Entries
Content-Language: en-US
From: NotYourFox <contact@notyourfox.coffee>
In-Reply-To: <20241024140353.384881-1-vladimir_putin_rus@kremlin.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

And what were you trying to accomplish?

On 10/23/24 1:45 PM, Linus Torvalds wrote:
 > Ok, lots of Russian trolls out and about.

You just made his statement valid by showing yourself off. Thanks for no 
help at all.

---

И что вы пытались этим сделать?

On 10/23/24 1:45 PM, Linus Torvalds wrote:
 > Ok, lots of Russian trolls out and about.

Вы только сделали его высказывание верным, решив выставить это напоказ. 
Спасибо за абсолютный ноль помощи.


