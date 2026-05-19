Return-Path: <dmaengine+bounces-10534-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HdtBPVODGpIeQUAu9opvQ
	(envelope-from <dmaengine+bounces-10534-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:52:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE78F57E105
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0058E303DDCA
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 11:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FFD4A2E1E;
	Tue, 19 May 2026 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0TPOmjb"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F6370AF4;
	Tue, 19 May 2026 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190823; cv=none; b=hpzt8W4g3Umztv9oh+yY9I6e357wlAD13z8vDkIEDmEC6PeGA1h9DH//bijePeNOnsR1FhuMIO3lvzgDtnOIoEv4ve0zJhDAN2WPuJJAm9GjPTLlkUPFKlNY3mlfgjDiiA8W3PJTQyZPLmKKPeBDSxDgSxYuJoICEzTyF3NQsYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190823; c=relaxed/simple;
	bh=QQaaGxQ5MASOA16eW1u17RV/meEJnJskrvGMHhJ6QeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfRFjpS077LvXhtU0z3kzy8nB8R8VeqWVdTNxyhVSdIWx78/Fe8DWuXg4Y9sUqP6SDwWLDwCU2DxvkA9I/dSGq3JNpl30hnAhdf4ewmc3ZWe0dsGFh9IY/wxu46j7L25XhxUR8D0VBkaf0a0Z4PrKG9oq6c+vVAz5+xxlUE7L1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0TPOmjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FFCC2BCB3;
	Tue, 19 May 2026 11:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779190823;
	bh=QQaaGxQ5MASOA16eW1u17RV/meEJnJskrvGMHhJ6QeQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G0TPOmjbmcvJIsyGp9Lt9WWuGrK3bSidLM55V8j1toGC08ccXy34OW+azx4MDkSV7
	 a/BjSolTL36yxsLoocb5XUNbmpvdpDCm+P1wzQ6KWLN2vZA6JE6WOXE6NoTfzmfUey
	 ef352MxE0yvpE8Idden2ACG12L3FEAoE2VydQ6X7abTwmp4W+J7UEPOHhQC0QxrCUv
	 A5SHqdGiPEPP28otiuD5aBL0d9JDnfKn5p70KSV2wgC/lhciRK56CwFnAc4hkqZKLg
	 mvQf2SluEbysYMgQBbiDmzhVt7XjUOIOl9GPWQDyB05H0C+RTfaFU1sGH/cIjAHr4+
	 Jh0UTs5zoTCUA==
Message-ID: <6b5378ed-270a-4ade-a944-654941ee9f8c@kernel.org>
Date: Tue, 19 May 2026 06:40:18 -0500
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nios2: remove the architecture
Content-Language: en-US
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 workflows@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-iio@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
 Hu Haowen <2023002089@link.tyut.edu.cn>, Kees Cook <kees@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nicholas Piggin <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Dave Penkler <dpenkler@gmail.com>,
 Andi Shyti <andi.shyti@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof WilczyDski <kwilczynski@kernel.org>,
 Andreas Oetken <andreas.oetken@siemens-energy.com>
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com>
 <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
 <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
 <20260519103012.blot4bssgiqfer6p@dev-vm-schuster> <agxBqd-ubOL2_i-j@shikoro>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <agxBqd-ubOL2_i-j@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10534-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,arndb.de,vger.kernel.org,lwn.net,linuxfoundation.org,kernel.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com,siemens-energy.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dinguyen@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CE78F57E105
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Simon,

On 5/19/26 05:55, Wolfram Sang wrote:
> Hi Simon,
> 
>>> ... but given this, you might want to get added in MAINTAINERS as
>>> reviewer (or even maintainer) for nios2? Besides that your efforts are
>>> already worth it in my book, it would also ensure you get CCed on
>>> patches like this. Then, you are not depending on people like Arnd
>>> putting you in the loop manually.
>>
>> Sure, I'd be glad to do so, but so far I refrained from it as I was a bit
>> unsure about the netiquette (can I simply do so by self-proclamation? At
>> least the git history seems to suggest so...).
> 
> In your case, you can do so, I'd say. You explained your very reasonable
> interest in the architecture and have already shown efforts to keep it,
> as we can see from the git history. The final call will be done by Dinh
> Nguyen obviously with whom you probably need to sort out details. But I
> can't imagine your offer for help will be rejected, quite the contrary.
> 

I 100% support adding you as a maintainer. Please send a patch.

Thanks,
Dinh


