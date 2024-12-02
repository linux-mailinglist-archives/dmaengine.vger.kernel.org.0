Return-Path: <dmaengine+bounces-3865-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1269B9E0CFA
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 21:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18900B2A70B
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 18:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873D61DE2AD;
	Mon,  2 Dec 2024 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="d1+850v/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2E5381C4;
	Mon,  2 Dec 2024 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733165518; cv=none; b=JzSjEjGJCFY/s2hdt6GhnevIRuPNJYjl0kdu8KXOOm8X8FRi+kRP/SUr+eUqhU14WMHGRhnYmf7qZXFeDrazFoxZ5dtwDKvD9r5TNtlIEQvSNLftkpMKgQrue2gAXgBRuzJQHXpaUIQj834dzY+eCt9Mw48JRn4LJiLJ1N64DwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733165518; c=relaxed/simple;
	bh=n24wWnsvKSEhSnkWZ3SQ2qlUtbn8L5c/kgAuqA70Ock=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJnmFvyG5z2cC92y41TI/IEYhO7ed98rizWTvttbN/uVbAPMTDh70nPJQ6YS25+0PATgPHLd/Njr48NisIbFYAkpkFfGKmT3dixnjlAFCp3o59WgV0DuYz9FQDlJ/QnJAsYTYqPnq2f8NI16+dNKoGNf4xojYWKi5aWwA6JKwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=d1+850v/; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1733165494; x=1733770294; i=wahrenst@gmx.net;
	bh=ZgB/0b4DRUYfPuTkx30gmOcph3LtRPAAxoRoTJ+aweo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=d1+850v/UjxK7V8+HZxecukwNyaInPHNRcoDefqRUjy9+ZdpDd+sAKJ92HDeKkaH
	 Ydlrz0Pa+y4aS2BwCL8BqHlrXJYHIbmDPDYzo9Jp2e5nDHCMro8kSopd/zvBw/xoP
	 GAhEdQvcO9aAhpaG3HXuJzo68/jfkNzxsZxFOnzMD/2EuBF1xBQUYxmxvB8uYyrvO
	 8pzhVWqLwm1TV8HzWSxUNiqoBRb0Mzg+rghtO1XrT0kMOCEmdgN4Tx7H4vo45EOPo
	 FP2RDPJP1UpwOUAsga8//6/14iZT5hLLeyP30ifrRuvDWwl6koEdW5QEAqyh/TpFf
	 +cIGeF5yaBkQPbZXew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.251.153]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeMt-1tDdDR35xj-00WWt9; Mon, 02
 Dec 2024 19:51:34 +0100
Message-ID: <d418a30d-f0b0-49c5-8f2a-ddda9a7eeb07@gmx.net>
Date: Mon, 2 Dec 2024 19:51:28 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/9] dmaengine: bcm2835-dma: add suspend/resume pm
 support
To: Vinod Koul <vkoul@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Minas Harutyunyan
 <hminas@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>,
 "Ivan T . Ivanov" <iivanov@suse.de>, linux-arm-kernel@lists.infradead.org,
 kernel-list@raspberrypi.com, bcm-kernel-feedback-list@broadcom.com,
 dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20241025103621.4780-1-wahrenst@gmx.net>
 <20241025103621.4780-3-wahrenst@gmx.net> <Z03l308ur7xuE1SB@vaman>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <Z03l308ur7xuE1SB@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JFDPQWC/iWpVzlUOkBhNid0hdinoSmvzk39ECSz5KjcFNJzYYLQ
 bBJMN8vYMo8K65/OG7nxKZi2ufJFsPLlUks4fTHwBgeG5A6u58gKNWajQ3rbJDbo69Q86rS
 RtZNPwoSGajeAVR+DOZiOCxm/H1bdwtbTF6N9RzFTSM5ECdql2Jx3a1XcD0+mDFkL8hSQvM
 A7RwEWwiFuPMe2lQdAq/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HAeP/ZkyvB4=;PI/pDBlpVI/bM72GS5GvEQE1UE8
 SKq+3RgesVtT2pv+9/2xfw+yP78CjWdpPe5yI9KVb7dkz4sIfpfmCOTWLNzTAS9F/qVhzn6xW
 HrqPuHyJVT/YEmcKwoANZMOOYoPmPpy9EtA4WpZU1Q0H5mCjWiM64ss1dM18TpohYmEA9shsX
 oPWAC9l0ksfyx5wQgXdG+815rPT11ve4dPBjIAJLH9xoKdVZ70OKTfMKxyc0zh09tP7MqdHCh
 8dAUwyzYVPKpcuyqoCTHlbVgs/2UPsNTS7pPOD+0DrL0dHC5o1xQbV7BYIhLLtoNTXkdIAPZl
 Joe0hw2nk1rUyWb5Uki0nJrNjVoNn2bUOVFd+wV1E2EbzRNOFBO6qMWIA5zxcywFv1zssKDBU
 8FJaldSzveeB8JY5hI3u3buV57t0sGzaHNzpiTY2fHqVStBzVrQ8eWgJtW9LmHM7IwyYyAfeo
 cr5FJ2bDtt9mIRn92X//m1rcSuoO9749wbPCi9+U389Z2/ZztyyfI0TsrfJfNuIjBzn/NtGj4
 XvOEAxzRSBFqJc1TR1PRrBjaCF3mYwMhy6groxUWSHKsrPaJ4a9ftYYWh5+VgVFRLlj7f8MAQ
 Sg92jkCl3N9fpW1yitEOfgNey/NGxTw7YFFU1iPAijVR9jgbVZJ3+nucM/U0Iu7GVmO0a1xzQ
 kpm/0eoFWNc1SX7hSSfiqCgbPDBrPxk7QS2DrsqKYhUNQlfVD//cWEj/PeWhP1NwEibciYC0+
 Jw19uT9aM412Gl/k5JtTl5GkBkqj7W7+4+nhL+vhfXp0MEMn/gzx0ckpQTQ561LJtnZnWidg/
 SA0LsUg1H2BFAR2V7lWDFe2kdTLQKisTyHn+70lAQ3rt8bRjL8W1nzL1Xe4Upw9Ad9KPSqB7U
 LHp7odcaeJqLLSATuOWSucCg4iJGFppwihygh8f0lcb37uGQ1OSrgNw/tBnD1ZIZc540i3IEF
 rrrxqKfio4YpH+u3rPfrMDnJblgubSmKTkaXGnJ2dofZOFlNklo5QHGBicf5N7oInPK/A1hVK
 xjD3Nz10ndbDDBdtiIB8jbdIP+34RC+c7C3NFE0F/5m61+PGIt8pfZb3KJAir9y7ekYerfQUa
 9wwDlmugDl457aIlAYHr3UmCetY4z8

Hi Vinod,

Am 02.12.24 um 17:52 schrieb Vinod Koul:
> On 25-10-24, 12:36, Stefan Wahren wrote:
>> bcm2835-dma provides the service to others, so it should
>> suspend late and resume early.
>>
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> ---
>>   drivers/dma/bcm2835-dma.c | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
>> index e1b92b4d7b05..647dda9f3376 100644
>> --- a/drivers/dma/bcm2835-dma.c
>> +++ b/drivers/dma/bcm2835-dma.c
>> @@ -875,6 +875,35 @@ static struct dma_chan *bcm2835_dma_xlate(struct o=
f_phandle_args *spec,
>>   	return chan;
>>   }
>>
>> +static int bcm2835_dma_suspend_late(struct device *dev)
>> +{
>> +	struct bcm2835_dmadev *od =3D dev_get_drvdata(dev);
>> +	struct bcm2835_chan *c, *next;
>> +
>> +	list_for_each_entry_safe(c, next, &od->ddev.channels,
>> +				 vc.chan.device_node) {
>> +		void __iomem *chan_base =3D c->chan_base;
>> +
>> +		if (readl(chan_base + BCM2835_DMA_ADDR)) {
>> +			dev_warn(dev, "Suspend is prevented by chan %d\n",
>> +				 c->ch);
>> +			return -EBUSY;
>> +		}
> Can you help understand how this helps by logging... we are not adding
> anything except checking this and resume is NOP as well!
My intention of this patch is just to make sure, that no DMA transfer is
in progress during late_suspend. So i followed the implementation of
fsldma.c

Additionally i added this warning mostly to know if this ever occurs.
But i wasn't able to trigger.

Should i drop the warning and make resume callback =3D NULL?

Best regards



