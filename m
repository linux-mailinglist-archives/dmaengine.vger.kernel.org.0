Return-Path: <dmaengine+bounces-7057-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADE5C3224B
	for <lists+dmaengine@lfdr.de>; Tue, 04 Nov 2025 17:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E083B4161
	for <lists+dmaengine@lfdr.de>; Tue,  4 Nov 2025 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47192333754;
	Tue,  4 Nov 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Q48stHsJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435933343D
	for <dmaengine@vger.kernel.org>; Tue,  4 Nov 2025 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275118; cv=none; b=NcTEbZYChljg663+m9Byn4++6IIMb/YrMEQ6zhwrs5vT9B/PttGjPCMDAM+uQQ9xSDXFqFUMUQUoa2F73ES2O1rRIwrf1cmEzXVYkOCB0OgDFf90NhxWqtiMdnx33yxspHWlFJ0i4BhytpU4Yki3YD8Po7hcvi5TMdBeaCCTkzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275118; c=relaxed/simple;
	bh=VqW/u8oKnuYD83GiHjandW7t8vndPzhPecw67ebGszE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=maLZ5VJ8uStVYwMNHZOIR5BEcMyPZYmcamuhOPfMrY9DW8KKlscjR5Anrn6i9CALtB1Aaj1R3I8XvNfBn5ws1ANUuUSYZaxeVCTWjioXQ+4npdXh6PUS+TGD4y5mNjCv5R8ytA+RB/lt6GhrQpLQpeiee33Y233alZZjZacA9DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=Q48stHsJ; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=VqW/u8oKnuYD83GiHjandW7t8vndPzhPecw67ebGszE=; b=Q48stHsJxKye5oKrC1MJ4YD684
	zyI/jOxWhcGPT92QpverIW9Ppyx6Ob1y0jGVKU9sc72Je9zeaPkhz84M+PZv2z2fHi4cuMIar52Gg
	4s+ZBU7hDmdu+EOEvuM1jQsqV/xvizd617gdOhrQl8AMMNJnbU+nHW7JmEDzcYqCdodJp8Fos9rjN
	Aq52ria+oIpzOLv00beJU07YFYkYZLVe1F6O5v1mOHuZQDuGDAQty1Zi/WclgB6K4y0NClka7x/eh
	sLpFJ5lVrX4yA0a8bFpE/xarFjPKGck/7OSVIA8eC9hfgWLZjw0/EFDbXqVg0K9DssxX5pGsKkiJ0
	QcccV7Gg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vGKG5-0000000Av8R-1umb;
	Tue, 04 Nov 2025 09:51:50 -0700
Message-ID: <161f0ff1-7e39-44bb-a6c8-c3ff745e9a27@deltatee.com>
Date: Tue, 4 Nov 2025 09:51:38 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vinod Koul <vkoul@kernel.org>
Cc: Kelvin Cao <kelvin.cao@microchip.com>, dmaengine@vger.kernel.org,
 George Ge <George.Ge@microchip.com>, Christoph Hellwig <hch@infradead.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>
References: <20251014192239.4770-1-logang@deltatee.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20251014192239.4770-1-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: vkoul@kernel.org, kelvin.cao@microchip.com, dmaengine@vger.kernel.org, George.Ge@microchip.com, hch@infradead.org, christophe.jaillet@wanadoo.fr
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 0/3] Switchtec Switch DMA Engine Driver
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Hi Vinod,

Any chance we can get some comments on our patch set this cycle? It has
been a couple months since we have heard anything.

Thank you,

Logan

