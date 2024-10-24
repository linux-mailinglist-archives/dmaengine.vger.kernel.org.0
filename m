Return-Path: <dmaengine+bounces-3468-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 013F19AE388
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 13:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3042F1C218B8
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 11:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284D41C303D;
	Thu, 24 Oct 2024 11:17:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D811B6D0A;
	Thu, 24 Oct 2024 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768641; cv=none; b=dMYj07k/4J2KIwyEnM07xfQsGSdxU8dpGKWm44qII7jSayaOXKzo8UWUY3UPAPKvEYy3hwgOMHeqxTttm3ZGH6TnIZKVBp31ikIdD77fSggd4Pz5SVKWzlx8ybHQETFiR2tIWgmGVMa8lHPt9iOCX8Jw5s9EuB1HjBQ8RHMJ+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768641; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h2MPjCF5ul0ReA18/SKdQVd/gVlC/5NdMq75520rztDyBzIfc14ywq+ITFYfi2TFQmIK4R4UhC69sLkrFEAmR82+7rYHsgi9FY3y2s1sFCjCi7LczNRzJN2HUpKLDdiORp7puNfDpg+aFq3aZfR06kmldLyPv1nEqKCKznQ4uVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.10])
	by gateway (Coremail) with SMTP id _____8AxquG4LBpncpoKAA--.24865S3;
	Thu, 24 Oct 2024 19:17:12 +0800 (CST)
Received: from localhost (unknown [10.20.42.10])
	by front1 (Coremail) with SMTP id qMiowMDx2OK3LBpnOWUPAA--.19906S2;
	Thu, 24 Oct 2024 19:17:11 +0800 (CST)
Date: Thu, 24 Oct 2024 19:17:34 +0800
From: Wanglei <wanglei@loongson.cn>
To: mike@altlinux.ru
Cc: aospan@netup.ru, conor.dooley@microchip.com, ddrokosov@sberdevices.ru,
	dmaengine@vger.kernel.org, dushistov@mail.ru,
	fancer.lancer@gmail.com, geert@linux-m68k.org,
	gregkh@linuxfoundation.org, hoan@os.amperecomputing.com,
	ink@jurassic.park.msu.ru, jeffbai@aosc.io, kexybiscuit@aosc.io,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	mattst88@gmail.com, netdev@vger.kernel.org, nikita@trvn.ru,
	ntb@lists.linux.dev, patches@lists.linux.dev,
	richard.henderson@linaro.org, s.shtylyov@omp.ru, serjk@netup.ru,
	shc_work@mail.ru, torvalds@linux-foundation.org,
	torvic9@mailbox.org, tsbogend@alpha.franken.de,
	v.georgiev@metrotek.ru, wangyuli@uniontech.com,
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Subject: Re: what about CoC? (was: [PATCH] Revert "MAINTAINERS: Remove some
 entries due to various compliance requirements.")
Message-ID: <20241024111734.GA22436@loongson-pc>
Reply-To: Wanglei <wanglei@loongson.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024095339.GA32487@imap.altlinux.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID:qMiowMDx2OK3LBpnOWUPAA--.19906S2
X-CM-SenderInfo: pzdqwzthl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUPKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21le4C262xC7I0v67AEwI8IwI
	1l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv2
	0xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7
	xvr2IY64vIr41lFIxGxcIEc7CjxVCFY4xvr7I5M4kE6I8I3I0E14AKx2xKxVC2ax8xMxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r4a6rW5MI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr0_Jr4lx4CE17CEb7AF67AK
	xVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07j0E__UUUUU=



