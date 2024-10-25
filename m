Return-Path: <dmaengine+bounces-3566-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB7E9AFBBB
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B700E1F23612
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 08:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066871C6F55;
	Fri, 25 Oct 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q3bpuJkx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iSm5PcWT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q3bpuJkx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iSm5PcWT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D153170A1C;
	Fri, 25 Oct 2024 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843206; cv=none; b=Z0/HCLoboPmDTFXc4UYOP9EtiJl+NxxJNwJpFcJjQFjDxsq5ozrZElkXqj0QlLzinMo8TAYKos5LwoSotfvqls1TQAxViqXOU+LpFVBC8EZFmNDPmTHLkhh52qZK3zgiYyLC0CVm5ZVGP0JPjsTsOxf+oRAWYVJBbiFaJ2bQyms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843206; c=relaxed/simple;
	bh=pDKoYNWc5esSfmM2VKEvc47EU0gOkj8FOL8qQDFJZYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3yUSWnigy60bFbw7c6IRgfHlXshTyd+aONOTTjV3D1AbMfwNKn0aQb2NHlMtGeQctlI7kpE9ubJuzrLZF7HqKOHOhkHuLUw03rkIrlWFsAIiBC0c5ZS+2bng8wJeEfmMvrE9x1td4JrOkqiFV6t8pqJWbe/GUXp8AG3qhP0VLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q3bpuJkx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iSm5PcWT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q3bpuJkx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iSm5PcWT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6FE8821E1F;
	Fri, 25 Oct 2024 08:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729843202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gt4eKGHTaDKGDIpEe7BbcCU3OPOhB5+NbtQhvob/2u0=;
	b=Q3bpuJkxSkOVve5uvDfli9jz2KlAsWAiPZucR6NpoGrjTSqrlZ9/qm3XU/eT9vQVnbET3I
	TTAAXXZP+7z0PHH0dA3MZuiTGQ2TFSNvfRJuCAYA+pc5kGIbuwT5wE/GSeonj4dnHxaqqc
	Fg6YV45j4Ieg70gSybwep693JDKmHFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729843202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gt4eKGHTaDKGDIpEe7BbcCU3OPOhB5+NbtQhvob/2u0=;
	b=iSm5PcWTohwwYs+NwSceqzvMUzvEepB2n1+Qq0val4EWG9nqyrd/iHlwKVqznKHhda8xxm
	Jc1ZYwjEHHsRlQDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729843202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gt4eKGHTaDKGDIpEe7BbcCU3OPOhB5+NbtQhvob/2u0=;
	b=Q3bpuJkxSkOVve5uvDfli9jz2KlAsWAiPZucR6NpoGrjTSqrlZ9/qm3XU/eT9vQVnbET3I
	TTAAXXZP+7z0PHH0dA3MZuiTGQ2TFSNvfRJuCAYA+pc5kGIbuwT5wE/GSeonj4dnHxaqqc
	Fg6YV45j4Ieg70gSybwep693JDKmHFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729843202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gt4eKGHTaDKGDIpEe7BbcCU3OPOhB5+NbtQhvob/2u0=;
	b=iSm5PcWTohwwYs+NwSceqzvMUzvEepB2n1+Qq0val4EWG9nqyrd/iHlwKVqznKHhda8xxm
	Jc1ZYwjEHHsRlQDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C94FB132D3;
	Fri, 25 Oct 2024 07:59:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1OmFJ/9PG2coWQAAD6G6ig
	(envelope-from <aherrmann@suse.de>); Fri, 25 Oct 2024 07:59:59 +0000
Date: Fri, 25 Oct 2024 09:59:53 +0200
From: Andreas Herrmann <aherrmann@suse.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	ntb@lists.linux.dev, Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	"paulburton@kernel.org" <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <olteanv@gmail.com>,
	Kelvin Cheung <keguang.zhang@gmail.com>,
	Yanteng Si <siyanteng@loongson.cn>, netdev@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org, Andrew Halaney <ajhalaney@gmail.com>,
	Nikita Travkin <nikita@trvn.ru>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Alexander Shiyan <shc_work@mail.ru>, Dmitry Kozlov <xeb@mail.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Evgeniy Dushistov <dushistov@mail.ru>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: linux: Goodbye from a Linux community volunteer
Message-ID: <20241025075953.GA3559@alberich>
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
 <753d203a-a008-4cd3-b053-38b5ce31281b@app.fastmail.com>
 <f90bba20e86dac698472d686be7ec565736adca0.camel@HansenPartnership.com>
 <2f203b14-be13-4eef-bcb1-743dd9e9e9bd@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f203b14-be13-4eef-bcb1-743dd9e9e9bd@app.fastmail.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,mail.ru];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[hansenpartnership.com,gmail.com,kudzu.us,intel.com,lists.linux.dev,kernel.org,linux.intel.com,bootlin.com,linux.dev,vger.kernel.org,alpha.franken.de,arndb.de,google.com,linaro.org,renesas.com,davemloft.net,redhat.com,lunn.ch,armlinux.org.uk,loongson.cn,roeck-us.net,alien8.de,linuxfoundation.org,trvn.ru,jurassic.park.msu.ru,mail.ru,omp.ru,linux-m68k.org,maquefel.me];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[53];
	R_RATELIMIT(0.00)[to_ip_from(RL9za9u4kxnfaar3549n6tyhyx)]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Oct 24, 2024 at 05:58:45PM +0100, Jiaxun Yang wrote:
> 
> 
> 在2024年10月24日十月 下午5:27，James Bottomley写道：
> > On Thu, 2024-10-24 at 16:59 +0100, Jiaxun Yang wrote:
> [...]
> 
> Hi James,
> 
> >
> > It's Linux, so no official capacity at all.  However, I am expressing
> > the views of a number of people I talked to but it's not fair of me to
> > name them.
> 
> Fair enough, I was hoping that it's from Linux Foundation but it's still
> good news to me that it do represent some respectful individuals.
> 
> >
> [...]
> >> How should we handle it?
> >
> > A big chunk of the reason it's taken so long just to get the above is
> > that the Lawyers (of which I'm not one) are still discussing the
> > specifics and will produce a much longer policy document later, so they
> > don't want to be drawn into questions like this.  However, my non-
> > legal-advice rule of thumb that I'm applying until I hear otherwise is
> > not on the SDN list, not a problem.
> 
> Thank you for sharing your insights. I'm looking forward to the document.

+1

> While I remain quite upset about how things were handled, your message has
> helped restore some of my confidence in the community.

+1

> I agree with Peter Cai's earlier comment that steps should be taken to address
> the harm caused by the initial reckless actions, particularly to those who were
> humiliated.

+1

> It is also important to put measures in place to prevent such drama from recurring.
> A formal procedure for handling urgent compliance requests may be a sensible step
> forward.

+1

> I hold our community in high regard and would be heartbreaking to see the reputation
> of the Linux Kernel undermined in such an unfortunate manner. I would appreciate it
> if you could convey those thoughts to the relevant individuals.

+1

-- 
Regards,
Andreas

PS: What people also tend to forget. No matter how worse it gets in
world affairs there always will come a time after a conflict. And
people with brains should look forward to such times and how they can
continue to work together then.

