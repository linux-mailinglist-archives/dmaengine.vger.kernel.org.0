Return-Path: <dmaengine+bounces-11114-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DxyUDoiGHmrAkgkAu9opvQ
	(envelope-from <dmaengine+bounces-11114-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 09:30:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C62C5629B4E
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 09:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3389A300C5BD
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jun 2026 07:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962613655CF;
	Tue,  2 Jun 2026 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flowmailer.net header.i=@flowmailer.net header.b="Toge8bLz";
	dkim=pass (2048-bit key) header.d=siemens-energy.com header.i=schuster.simon@siemens-energy.com header.b="ec+PfJIe"
X-Original-To: dmaengine@vger.kernel.org
Received: from mta-64-141.flowmailer.net (mta-64-141.flowmailer.net [185.136.64.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BFA35DD1C
	for <dmaengine@vger.kernel.org>; Tue,  2 Jun 2026 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385008; cv=none; b=VcDPw7QAEh2QFbYKM0LuV9BgNzemEqbunR36sxZH/PFXUk8LY5AWeMyc+mC8vfrAhkI3sQzjPeB/Rs06W82qT0oLlZFjOI8sj+15SUM6l3fresmc2Lp0LNCAzqRukHTCjlTeD3CLVBfmcg5QGPT/nkGOxlFkZkHqahM5cdENFio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385008; c=relaxed/simple;
	bh=rTMmvdqLn8XGVIbwx6QxILaPnIKuu93HhNdO2BLhr54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=It46gSDzu/p1UaIvelGnjWK1gQ49wfhyq6z0wMZ5pzwHz9F04Wiu5sfJgMfxEfJszFcapsIPsbDsLSP3Ga3DCn3DG5QA5QpsAlvYB3NyfhQkCVVX/KF4SU4kQOhTcu2ippHBAYMjLOzu/IWt302h6/lrTYGc4gh1eK8WY9GXBSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens-energy.com; spf=pass smtp.mailfrom=errorhandling.siemens-energy.com; dkim=pass (1024-bit key) header.d=flowmailer.net header.i=@flowmailer.net header.b=Toge8bLz; dkim=pass (2048-bit key) header.d=siemens-energy.com header.i=schuster.simon@siemens-energy.com header.b=ec+PfJIe; arc=none smtp.client-ip=185.136.64.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens-energy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=errorhandling.siemens-energy.com
Received: by mta-64-141.flowmailer.net with ESMTPSA id 2026060207131481cdadc4760019fd9d
        for <dmaengine@vger.kernel.org>;
        Tue, 02 Jun 2026 09:13:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=s1;
 d=flowmailer.net;
 h=from:from:sender:to:to:cc:cc:subject:subject:content-type:content-type:content-transfer-encoding:References:In-Reply-To:Date:Message-ID:MIME-Version;
 bh=rTMmvdqLn8XGVIbwx6QxILaPnIKuu93HhNdO2BLhr54=;
 b=Toge8bLz2dyLab0qL8rkthmm38M0DIbWMwxIZTkHCglUndNKtXlsEFzupMzU1i/vzCdijc
 miocQZzlL9bzz0ZuwDfASqzdjU/d6NY+xy09C5rIOtPgu1bTsWHtrNYMYexJC33Ow7Pw9BIh
 4PggmgbDjvYm9EN9UTfgesMkNvRAg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm3;
 d=siemens-energy.com; i=schuster.simon@siemens-energy.com;
 h=from:from:sender:to:to:cc:cc:subject:subject:content-type:content-type:content-transfer-encoding:References:In-Reply-To:Date:Message-ID:MIME-Version;
 bh=rTMmvdqLn8XGVIbwx6QxILaPnIKuu93HhNdO2BLhr54=;
 b=ec+PfJIeqY0XmjF70C+uM3vKHeUzZAh1oTg2/qKJ7kPp6hfzDsi97fQ48IoGRskdwuz7Cu
 BGbuFZJ1Q9hHZckYImkEVD3l7jGDitagbUlrsjtMZGp7BQq6QWHs2rCwJGEOP6xEi685QNoj
 Dhxnc4HYfsbAg8Fm/fRfi0hYIxCejI2QpzVxqaXoytvcWrW15vVIQ9nYgGgotDILZbmKgedc
 b8LJKCIxu/nklS6gM/yKotmExl+J8oVb93bKKA61U9r3GprrFfQDONQGoXo5/evBr8Iz8wW4
 xRQAllgjoeOQIpdd6p46Xuo84qL1JvVLvPqgCUmzpiwzXycLeLiQhrYQ==;
Date: Tue, 2 Jun 2026 09:13:11 +0200
From: Simon Schuster <schuster.simon@siemens-energy.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ethan Nelson-Moore
 <enelsonmoore@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Dinh
 Nguyen <dinguyen@kernel.org>, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, workflows@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>, dmaengine@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, Netdev
 <netdev@vger.kernel.org>, linux-pci@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kbuild@vger.kernel.org, "linux-csky@vger.kernel.org"
 <linux-csky@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Dongliang
 Mu <dzm91@hust.edu.cn>, Hu Haowen <2023002089@link.tyut.edu.cn>, Kees Cook
 <kees@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Will Deacon
 <will@kernel.org>, "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin
 <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>, Frank Li
 <Frank.Li@kernel.org>, Dave Penkler <dpenkler@gmail.com>, Andi Shyti
 <andi.shyti@kernel.org>, Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 WilczyDski <kwilczynski@kernel.org>, Andreas Oetken
 <andreas.oetken@siemens-energy.com>
Subject: Re: [PATCH] nios2: remove the architecture
Message-ID: <20260602071311.gtvif43wcjyulphh@dev-vm-schuster>
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com>
 <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
 <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
 <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
 <CANiq72=6oYtHf0Q1NaLXZ+25uQyYbej2xnvUhtgpHyvozhP7_Q@mail.gmail.com>
 <ah3TN93e7lRpVihW@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah3TN93e7lRpVihW@ashevche-desk.local>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens-energy.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[flowmailer.net:s=s1,siemens-energy.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11114-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,sang-engineering.com,infradead.org,arndb.de,kernel.org,vger.kernel.org,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com,siemens-energy.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[53];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuster.simon@siemens-energy.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[flowmailer.net:+,siemens-energy.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flowmailer.net:dkim,siemens-energy.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C62C5629B4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Andy,

On Mon, Jun 01, 2026 at 09:45:11PM +0300, Andy Shevchenko wrote:
> Supported implies that one gets real money for the job. Is this the case here?

Thank you for caring about NIOSII. I'm doing so as part of my
employment at Siemens Energy; if this is real enough then yes :)

Best regards
Simon

