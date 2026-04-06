Return-Path: <dmaengine+bounces-9886-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AWiA4JJ02k0gwcAu9opvQ
	(envelope-from <dmaengine+bounces-9886-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Apr 2026 07:49:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FAD3A1A6A
	for <lists+dmaengine@lfdr.de>; Mon, 06 Apr 2026 07:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D21F300F95A
	for <lists+dmaengine@lfdr.de>; Mon,  6 Apr 2026 05:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939A233AD9B;
	Mon,  6 Apr 2026 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgXI890r"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06A3090D7;
	Mon,  6 Apr 2026 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775454589; cv=none; b=LBSusPKa43umQ/OW7TAp2HwE/l7yTCi00tz4bA4zgnZwmNXAI18sTft4G/WhbRCrVP2Zk7w1yNzJ6WwG8j1L8zrQ9qFl2XPa67zEQ9iMQPjV5vF/NU6lX3+eKI3MqIw+Elj+gh9SwqXloanyGUXx6PfyT9Eu+DI4/k6fFhowlHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775454589; c=relaxed/simple;
	bh=4thoVWcMmw4MkYMp3l5E6+QpX/OSrE+K9Cc8bqDe0Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQA4CbXkLBh/o9TM0l3GHR8HOE78UCdfBV72jWkwslMVUXRxJS+ZcLeyesQw5vQW7xivUc9xGXMEe0ISToWApF++OWszmBh55flPbttz3W3kBqutDVv4gX9JDszEfNZNZJTFeurTcw8uGPXfV4+b5hO5YcXPImqnU7CPVa/GgBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgXI890r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BD2C4CEF7;
	Mon,  6 Apr 2026 05:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775454589;
	bh=4thoVWcMmw4MkYMp3l5E6+QpX/OSrE+K9Cc8bqDe0Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bgXI890rX05ktv9oPv33HQAY90wguIlq0zeVRBIbmeDKXLA/c1mE1e5ydxu7hcduI
	 kTZ9nO2+CkEVZjIDQGxe5bkfu2tmthXMLqKff1bqGFPaj+08+iHC08xjxc92g1DPEE
	 KwVzjDTLqo2zhZDXkIrcuY5ezh3/H92TsCyGn+R1UdZRVT4pOQwueRJNE+JlSFvysL
	 s3ofTuZZGE6Y2soiw9bIkJ/yTIdEF/ZL9+ftN7CICVlDH8rbwnbFFIAgWY4IyHBOsS
	 w2C3bcHMNGEXDzAizYg/NRL6FHwycOJuhBHTezD2YnqnSWkNgtd7JsDL5QtQx8LstU
	 +278O8yuLefAQ==
Date: Mon, 6 Apr 2026 11:19:45 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Saravana Kannan <saravanak@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>,
	Johan Hovold <johan@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Robin Murphy <robin.murphy@arm.com>, Frank.Li@kernel.org,
	alex@ghiti.fr, andre.przywara@arm.com, andrew@lunn.ch,
	aou@eecs.berkeley.edu, catalin.marinas@arm.com,
	dmaengine@vger.kernel.org, driver-core@lists.linux.dev,
	gregory.clement@bootlin.com, iommu@lists.linux.dev, jgg@ziepe.ca,
	kees@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org,
	linux@armlinux.org.uk, m.szyprowski@samsung.com, palmer@dabbelt.com,
	peter.ujfalusi@gmail.com, pjw@kernel.org,
	sebastian.hesselbarth@gmail.com, tsbogend@alpha.franken.de,
	vgupta@kernel.org, will@kernel.org, willy@infradead.org
Subject: Re: [PATCH v4 7/9] driver core: Replace dev->dma_coherent with
 dev_dma_coherent()
Message-ID: <adNJebiLoHqgQEyZ@vaman>
References: <20260404000644.522677-1-dianders@chromium.org>
 <20260403170432.v4.7.If839f6dde98979fce177f70c6c74689a1904ee76@changeid>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403170432.v4.7.If839f6dde98979fce177f70c6c74689a1904ee76@changeid>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9886-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,rowland.harvard.edu,lst.de,google.com,intel.com,ozlabs.ru,arm.com,ghiti.fr,lunn.ch,eecs.berkeley.edu,vger.kernel.org,lists.linux.dev,bootlin.com,ziepe.ca,lists.infradead.org,armlinux.org.uk,samsung.com,dabbelt.com,gmail.com,alpha.franken.de,infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 78FAD3A1A6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03-04-26, 17:05, Douglas Anderson wrote:
> In C, bitfields are not necessarily safe to modify from multiple
> threads without locking. Switch "dma_coherent" over to the "flags"
> field so modifications are safe.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

