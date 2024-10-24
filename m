Return-Path: <dmaengine+bounces-3560-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A549AF398
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 22:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD78B2169A
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9501D1AE006;
	Thu, 24 Oct 2024 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="A6QuAwzx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2933922B645;
	Thu, 24 Oct 2024 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801357; cv=none; b=OqBUvXHu0ILfmz7kYOUDzMsSFo+b3vZN9qhgUh+9IP9e18edsRut4CxKj8OGX4iLVv94/A5RukiHh/CQmprhvWmgTT3eLpqcbs+FPCqdL9Nhn7E9hBHyudJC6o1V0HNly2wna4WrQ8jyGQ7GxOs8XvHbKNvq0+yBs6cJNHfO2vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801357; c=relaxed/simple;
	bh=vABJavO4pEiQ96+vgr7qfTrEw4MrUnKuz6oyeSkd6As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLOWpN6gcbHT7Ftn3CKdN2ymRynJghOLInQ+KSgD3DZ9BQHo2sb8kxBIlpocyWUPs7cFGmc9/iIrDyu0CdS934YkPQR9XCxcQXEPFHth2f0LImvwIoG8NT90RkUp9O1VnLjJIXzRFdQlZnGqLPG2PTkLEGPz+pIVX46/jtwhEvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=A6QuAwzx; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729801322; x=1730406122; i=wahrenst@gmx.net;
	bh=37AVnEl12mgQ2AzGMtku37GRus5QseHOCkvfk6gJraw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=A6QuAwzxCLx8Tm4nUJPVYlsaw7UFQRiLHV4oDIRi7Hgy701QL2FVHegjH9Gs3dBF
	 tMfFIg+Kcz7NveWEvcZz/xmuEePxJOg87JEgem776OzwTmNHQbOUtFNhZc8htpeIA
	 ymsWzBSJpmB/4SkEA2CsMl2I187zvm7seIvO/1h2owlB9Ww7JwzzW1PNIFPQaK4a2
	 cTKYChhk803qoAdteJWwIu6/uX5yidGyEY1nn6/uUtMr/JwDilk/+d/pmJ8RZxjoh
	 RkxC3VJyxWPCnroPMxln0s1UA7riIIw/vWffXI8f2WcuW0IaLzdvTQSAubwAcY2z1
	 xfTyXdbvuiEGhxhFrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJlc-1tmzT32o7w-00fEad; Thu, 24
 Oct 2024 22:22:02 +0200
Message-ID: <66100833-88a1-454a-9061-282a91fd559b@gmx.net>
Date: Thu, 24 Oct 2024 22:21:57 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/9] ARM: bcm2835: Implement initial S2Idle for
 Raspberry Pi
To: Russell King <linux@armlinux.org.uk>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Vinod Koul <vkoul@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Minas Harutyunyan <hminas@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>,
 linux-arm-kernel@lists.infradead.org, kernel-list@raspberrypi.com,
 bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org
References: <20241024201837.79927-1-wahrenst@gmx.net>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241024201837.79927-1-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DH/WV2iyssAhp5fvEKSNmCmbV0Rro6NffSfwVliXmQZ2N4I74VO
 rJSBTwAyuJLHriIw12l59ZRhJTb8Nj5TaQMykVpzBc8aqGgOZ3VXv2OjRNHeAzWJL9Epzsc
 fF1e8UwqgdLFQ/5Bs0Z7xjGoIsqLyjn+R72mpTOzLOmzgGmhzS2Rb9EOqICa1lMduYj9Jxo
 rBV1OlJmT7VQIY71n1ZQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a7NpCfSQrp0=;ngjzFUvKBoHYBM+wvyDWmtYF1sB
 hpUW158gUOLGTKHP3h7apQyVcxOTU5npUhf5vRITrjbd93o0/CTQI5fL1Ret5UPn9pu78RVr1
 sdCQR50ebMBn+0jhMVUvslfurn+DuP4GoXipjYn9lJ5Vx+Vtwh4OF8GBQUKR5AbcDxdjHhWFi
 i2HUxk5HIlLGlNM08ns3K/sIsrMGi38JMkcCNdvzlHg32mY19innX5H/VCTDHdZLNMBWHE1rT
 dyo5V3/lzK88vf1dzop1obRa4Ur+ytu/jkXGtJxy1VVFB85q+Y/TZtutIJND0B6iiaWwysPs+
 9b7L4s84lrJtx4njt/4g7FUstJXKhj1v1JaPMCap3XRehtn+HHH9rqSJU4zqQJscfB6KCbgwV
 FoDKc80ebdLuQebbwp3rc5BateQCPLBI9zbOE+xPNIulORDFqeqtuP0jfOf1c86letyVXzetu
 rxBozt5uHuSDZE71AtGXySfA7MALq4trTuq7CoTvPzyZZGSvyZkuGuxb+COdi2bEO9F2DKUAn
 dRmaLgc83x1t3c7kYEX5WpAaSFqIxnjF+v1QyPZ8cBQv0lb5WpaKiq/NyC5rD1cXMHjXu/GXO
 Vvsi3HRaq54Q3Ws1faj0WqxwzdWRx4rJJCgsXXKF5yg0EgkQZJZf1sqtw4Qa679LXcZqT9nyz
 VLuTWAh+tP6N7/qoPFlAYMrhpdphMhaso1tiTYepl0iCMabZH7tRpWUn18Ugm2ynDSVDPCxY8
 XrrqjCXpWQVxP/WOJUo5Q1t3eQqyxCZ2Ica/x0hZECdpOMhggNy2oYv9OcG6fT6Uc/F5DjHmi
 1+12oYxaUboF7Mdg/WwB79VA==

Am 24.10.24 um 22:18 schrieb Stefan Wahren:
> This series implement the initial S2Idle support for
> the Raspberry Pi, which was a long time on my TODO list [1]. The
> changes allow to suspend and resume the Raspberry Pi via debug UART.
> The focus is on the BCM2835 SoC, because it's less complex than its
> successors and have enough documentation.
>
> Now the VC4 part has been split from the series [4], because of some issues
> in that part.
>
> Cherry-picking of patches should be fine.
>
> Test steps:
> - configure debug console (pl011 or mini UART) as wakeup source
> - send system to idle state
>
>    echo freeze > /sys/power/state
>
> - wakeup system by console traffic
>
> The clock gating must be restored, because otherwise we have a
> regression on Raspberry Pi 3 B+ . Luckily the disabling of clock gating
> isn't necessary anymore. Thanks to the rest of the DWC2 patches which
> based on an idea of Doug Anderson. The USB domain is now powered down
> and the USB devices are still usable after resume. There might be room
> for improvements, but at least the system won't freeze forever as before.
>
> Here are some figures for the Raspberry Pi 1 (without any
> devices connected except of a debug UART):
>
> running but CPU idle = 1.67 W
> S2Idle               = 1.33 W
>
> In comparison with HDMI & USB keyboard connected (but neither active
> nor wakeup source):
>
> running but CPU idle = 1.82 W
> S2Idle               = 1.33 W
>
> The series has been successfully tested on the following platforms:
> Raspberry Pi 1 B
> Raspberry Pi 3 B+
>
> Changes in V4:
> - added Reviewed-by from Doug
> - dropped applied VC4 improvement patches
> - fix DWC2 register backup
> - add revert because of Raspberry Pi 3B+ regression
> - add suspend/resume support for DMA & eMMC to be on the safe side
Sorry, i missed the version in the other patches :-(

