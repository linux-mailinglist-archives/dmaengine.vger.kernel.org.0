Return-Path: <dmaengine+bounces-3469-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC309AE39A
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 13:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B863D1F23245
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 11:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC711CB9FA;
	Thu, 24 Oct 2024 11:17:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCF51B6D0A;
	Thu, 24 Oct 2024 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768649; cv=none; b=osYG/XFbPkgduyydPphH3ovI/mqi6e3zEtcx7yEyTvfagZTGtN92nwvLZKsPIfVxSdmmNEawIWtftPYGIPToQ6x833fWY6T7f6CRfI0+8n0doC4HHLrCQmV0/wsgzvIFPQXupjeoTMYUiHI1YKZHhTxjTNBxJr6jZ1mGQ/7yfSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768649; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KPeWAJ7UP82oMrCCYLLfMmtuafrhEI5F/JR+NcosqvorXuK1rqBgUljctYd5dQ+A9ZGkZaIfAft5Cvm9mA0bGfx6RXjlyGt3e8cCvT7BRt712uRccW1QNh7B2GpIimInmMNLBw2G2E4MGHC0t9Gbs0D5xmgiOLJsWedtH8bb/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.10])
	by gateway (Coremail) with SMTP id _____8DxG+LCLBpnkZoKAA--.24431S3;
	Thu, 24 Oct 2024 19:17:22 +0800 (CST)
Received: from localhost (unknown [10.20.42.10])
	by front1 (Coremail) with SMTP id qMiowMAxbODALBpnS2UPAA--.19609S2;
	Thu, 24 Oct 2024 19:17:21 +0800 (CST)
Date: Thu, 24 Oct 2024 19:17:44 +0800
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
Message-ID: <20241024111744.GA22673@loongson-pc>
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
X-CM-TRANSID:qMiowMAxbODALBpnS2UPAA--.19609S2
X-CM-SenderInfo: pzdqwzthl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUmjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487M2AExVAIFx02aVAFz4v204
	v7Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IY
	x2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4
	x0Y48IcVAKI48JM4IIrI8v6xkF7I0E4cxCY480cwAKzVC20s0267AEwI8IwI0ExsIj0wCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWrXVW3Aw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r1j6r18MI8E67AF67kF1VAF
	wI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU035r7UUUUU==



