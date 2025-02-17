Return-Path: <dmaengine+bounces-4508-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5609AA37E94
	for <lists+dmaengine@lfdr.de>; Mon, 17 Feb 2025 10:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520A37A4BE5
	for <lists+dmaengine@lfdr.de>; Mon, 17 Feb 2025 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926D52153D1;
	Mon, 17 Feb 2025 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fK/H46QJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BF921519C;
	Mon, 17 Feb 2025 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739784677; cv=none; b=ulOktqqRNfoXDIsk2NBqhnfPAOBrnjIH1BcyyW7IcRRSX+LFfWtVj4mIwt8WUxL2X3KIftuWNO+Xx3ylICEzuueG2qIkB8tGvj0B2Xi0+yXKCq3y3QAAxjwj4YCUaHShJzR7n21qBtvIVvqsBrk1V1/i0CR2Jjfg3cbppCqXqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739784677; c=relaxed/simple;
	bh=BF3BWMnRAgV+XVc7QLQRap/ja+b/weSZ+YkZOb083OM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FppWIrHncgthL/3PAW17LeknnXOPLzh+HVIqoKzujxJs+Vft7irobBNoGbojA8Mk0psF/vWiF/Jhb9+rbku5knZ9XCmA8FuxdUNGyaerS75h/Kd3IB3AZnnxgK/Hy1utkQobRzd+aZDJJBFJlZglMcETZmy7mFfel2hXRSsJSqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fK/H46QJ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D2C04328A;
	Mon, 17 Feb 2025 09:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739784672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzSgtFsogf3LvL+ai4nE5Lt4B+3+Fu9VUwcYPOuEIZQ=;
	b=fK/H46QJFMLPMcRVkjjcBvXz3suQapWq9E5PCchE4muxik4Ug0FIztPKlE1SGb5DuDwz5a
	Uoo/64V/Eik/EAM40u63rxPdOzMTUc5FKFGxbkaMwRtBN5QXugz6xEKYFf59C2CPI3qGmh
	u2dWyZ6LCPd2sA0i6Nm2l6QZWCbNwHDiaPP9GOa9zcetatAYq2HNqRYOpUPYEdK/9SEZcv
	QBSU/EiTcIELPURB8EgJ9MV8wakky8b0GJorTq/QHU9O5rUi5u4wERdnNw3OTb4gL4kLQh
	1ripd4J1y7IWjqrj7Anhj4dIEqUdf7WF3Tl1AosWjOQZfn//HL8/QDLv01yDpA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: J. =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: J. =?utf-8?Q?Neusch=C3=A4fer?= via B4 Relay
 <devnull+j.ne.posteo.net@kernel.org>,
  devicetree@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,  Krzysztof
 Kozlowski <krzk@kernel.org>,  imx@lists.linux.dev,  Scott Wood
 <oss@buserror.net>,  Madhavan Srinivasan <maddy@linux.ibm.com>,  Michael
 Ellerman <mpe@ellerman.id.au>,  Nicholas Piggin <npiggin@gmail.com>,
  Christophe Leroy <christophe.leroy@csgroup.eu>,  Naveen N Rao
 <naveen@kernel.org>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Damien Le Moal
 <dlemoal@kernel.org>,  Niklas Cassel <cassel@kernel.org>,  Herbert Xu
 <herbert@gondor.apana.org.au>,  "David S. Miller" <davem@davemloft.net>,
  Lee Jones <lee@kernel.org>,  Vinod Koul <vkoul@kernel.org>,  Lorenzo
 Pieralisi <lpieralisi@kernel.org>,  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,
  Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,  Bjorn Helgaas
 <bhelgaas@google.com>,  J. =?utf-8?Q?Neusch=C3=A4fer?=
 <j.neuschaefer@gmx.net>,  Wim Van
 Sebroeck <wim@linux-watchdog.org>,  Guenter Roeck <linux@roeck-us.net>,
  Mark Brown <broonie@kernel.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-ide@vger.kernel.org,  linux-crypto@vger.kernel.org,
  dmaengine@vger.kernel.org,  linux-pci@vger.kernel.org,
  linux-watchdog@vger.kernel.org,  linux-spi@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 12/12] dt-bindings: mtd: raw-nand-chip: Relax node
 name pattern
In-Reply-To: <Z7Iqir-qaZDt6tsx@probook> ("J. =?utf-8?Q?Neusch=C3=A4fer=22'?=
 =?utf-8?Q?s?= message of "Sun, 16
	Feb 2025 18:12:26 +0000")
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
	<20250207-ppcyaml-v2-12-8137b0c42526@posteo.net>
	<87o6zaurv9.fsf@bootlin.com> <Z7Iqir-qaZDt6tsx@probook>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 17 Feb 2025 10:31:08 +0100
Message-ID: <87tt8svrxf.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkedtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdevhffgtdfhhefggeeftdeiffduiedtgffftddutdehteejhfevieelveegveetnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefledprhgtphhtthhopehjrdhnvgesphhoshhtvghordhnvghtpdhrtghpthhtohepuggvvhhnuhhllhdojhdrnhgvrdhpohhsthgvohdrnhgvtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoi
 ihlrggsshdrohhrghdprhgtphhtthhopehkrhiikheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhmgieslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehoshhssegsuhhsvghrrhhorhdrnhgvthdprhgtphhtthhopehmrgguugihsehlihhnuhigrdhisghmrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

>> > In some scenarios, such as under the Freescale eLBC bus, there are raw
>> > NAND chips with a unit address that has a comma in it (cs,offset).
>> > Relax the $nodename pattern in raw-nand-chip.yaml to allow such unit
>> > addresses.
>>=20
>> This is super specific to this controller, I'd rather avoid that in the
>> main (shared) files. I believe you can force another node name in the
>> controller's binding instead?
>
> It's a bit tricky. AFAICS, when I declare a node name pattern in my
> specific binding in addition to the generic binding, the result is that
> both of them apply, so I can't relax stricter requirements:
>
> # raw-nand-chip.yaml
> properties:
>   $nodename:
>     pattern: "^nand@[a-f0-9]$"
>
> # fsl,elbc-fcm-nand.yaml
> properties:
>   $nodename:
>     pattern: "^nand@[a-f0-9](,[0-9a-f]*)?$"

Well, I guess this is creating a second possible node name.

> # dtc
> /.../fsl,elbc-fcm-nand.example.dtb:
> nand@1,0: $nodename:0: 'nand@1,0' does not match '^nand@[a-f0-9]$'
>         from schema $id:
> 	http://devicetree.org/schemas/mtd/fsl,elbc-fcm-nand.yaml#

What about fixing the DT instead?

> (I changed the second pattern to nand-fail@... and dtc warned about it
>  mismatching too.)
>
> Perhaps I'm missing a DT-schema trick to override a value/pattern.
>
> Alternatively (pending discussion on patch 11/12), I might end up not
> referencing raw-nand-chip.yaml.

Ok.

Thanks,
Miqu=C3=A8l

