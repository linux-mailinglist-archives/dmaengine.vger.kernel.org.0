Return-Path: <dmaengine+bounces-10885-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aANxI32RFGrnOQcAu9opvQ
	(envelope-from <dmaengine+bounces-10885-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 20:14:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C58645CD93C
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 20:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 699243013A90
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 18:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080A234E761;
	Mon, 25 May 2026 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="PLOr+M1X"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F9734D929
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779732858; cv=none; b=oSYBM/QCVvAWOTA2I6fOeC9SE70dn0tQRupAlkElPG8RRQJ823ESYAkEuARivz2X36RfW4DIuxFHkjSiEIyfW6Zudu8tD/V/q3HpvYnDGKkN44ltPQlwhiAKpUEJZWpCVlBVi8grZ4BM8Y+x46gxaotVmw+ijioQQnowIYnVkNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779732858; c=relaxed/simple;
	bh=Zdb6qlIBOgGM3tN1a+65vupLceom4UoJtB8lJlswxTI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Content-Type:Subject; b=UekhdUgUu5crWwpeNSRagEBMI1hMIchGrEwhO6FMa/2RgIPgX2Hqs1P/NgbhJnr/6em0xA520m6gXJARME0NBtV/p9wzMBmxYDDNThYt9t/5ibVMk8F6PYFArdYM9UfU1UxWoBwlCgCFelV+ZIrM04frupzAVDK1sXaDXGwaWkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=PLOr+M1X; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:From:Cc:To:MIME-Version:Date:Message-ID
	:references:content-disposition:in-reply-to;
	bh=Zdb6qlIBOgGM3tN1a+65vupLceom4UoJtB8lJlswxTI=; b=PLOr+M1XM61SQ7P8RKjKihM0r2
	u5869KxFOxPx4Qv4uAVF76NYf2UNeIN5P5Jd451txQquPhbks/rzDMHRg3a0Cg7uZUT5ouM6d4nN9
	sHxoaUKp0kovV7RY9swWaD+vRS8UZQcmdXhm+/GylCBN3ppsq3iBNQo0Bz/ob9i2Yt0JfArazcAbD
	Q5QqApxOXhbm0a7oKsTiqM6X1tz1YEX81Xj4M8agUTZ6QSzy7TSa8ju5USLtbCt8woT3inkuLJOqf
	gmC2XspxbLwpz5nLxsO5P+dgYjinr3Q0h+/wkojwgD3+B02ZO2W5a7MGWxeYx3D7ShTKtuB7W0MT3
	X8eFYkAA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wRZoe-000000004KA-1p7o;
	Mon, 25 May 2026 12:14:17 -0600
Message-ID: <73349ba3-2755-4acb-812c-75edb9ff6ec7@deltatee.com>
Date: Mon, 25 May 2026 12:14:05 -0600
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-CA
To: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Frank Li <Frank.li@nxp.com>, Kelvin Cao <Kelvin.Cao@microchip.com>
From: Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dmaengine@vger.kernel.org, vkoul@kernel.org, hch@lst.de, Frank.li@nxp.com, Kelvin.Cao@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Question on adding sysfs entries to dmaengine devices
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[deltatee.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[deltatee.com:s=20200525];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10885-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[logang@deltatee.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[deltatee.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C58645CD93C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Now that the switchtec-dma driver is merged there is some work we have
started to add some sysfs attributes which can be used to tune the
hardware. However, we have some questions on the best way to do that as
the existing approaches are a bit questionable.

We need to add configuration attributes on a per-channel basis. ioat
seems to be the only existing driver that does this. We considered
copying the implementation, but it's a bit questionably as it uses
kobject_init_and_add() directly to manually add attributes to the dma
channel's device object. Which doesn't seem great.

We considered adding attributes to the PCI driver instead of the dma
device as that is in the control of the switchtec-dma driver, however,
that is complicated because it would have to create a new sysfs
directory for every channel so I'm not sure the resulting code will be
much cleaner.

I'd appreciate any advice we can get on the best approach here.

I'm leaning towards cleaning up the ioat code to make adding channel
attributes a feature of the dma-engine instead of having the low lever
bits done in ioat. Then we would use the same interface in switchtec-dma.

Thanks,

Logan



