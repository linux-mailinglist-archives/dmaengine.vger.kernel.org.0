Return-Path: <dmaengine+bounces-3481-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8CB9AEC05
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 18:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C007D1C21E02
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 16:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F29F1F8191;
	Thu, 24 Oct 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="aZbVPBF+";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="aZbVPBF+"
X-Original-To: dmaengine@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ADF1F80CC;
	Thu, 24 Oct 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787282; cv=none; b=Gr08zSQa2Blv2Pyya4mLgd0CPu6X1zm3xJs716T1/cxAiuiD85d3l38xxswzQi/gCjnh53AC8inMAtqbivNb9kEhobmo8V0xUQdsU74uPWtE0t2dE3Wk/Z2EpbYg2UhpP+kKJzb+KiIC/GoouZGMHwspl+q8eGS3sz7fQL3l7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787282; c=relaxed/simple;
	bh=Rrc56uTnfRNdC1bewUry4Xfnxz5KZpPPiUjQQRJFyU4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=exSJziHCvDcGAShmvavdK84vxeyXyu/bsi5V4p6DgWk5vbDt9LTr86LoG3+DbPbbzGV5w6i+KhSiOJSUBcFZsRi7WcSnun5Vj93LSHoc62f3weUIHcyEIwpXiW591rEPSqfsBRS9isgvNjGgE3PKn+q5iQnw/BoroG9CCVfzNWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=aZbVPBF+; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=aZbVPBF+; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1729787275;
	bh=Rrc56uTnfRNdC1bewUry4Xfnxz5KZpPPiUjQQRJFyU4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=aZbVPBF+axigjMKsw1msqICxBnjDWBRgdI0ct3T7Kf898m8kTzL9UA31mp7dLLOSJ
	 XQ+g2sskTIVJyy2D6A2dXk/UjRYJdzh9N93DjRLWJ26LHk3xkGPAy6W90rYsfsqPEr
	 cQdcwBMYVVqDWYQLGCFWkS6heSDbavxlERDs9lgI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C319B128799E;
	Thu, 24 Oct 2024 12:27:55 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id FlqUVcMmUqoz; Thu, 24 Oct 2024 12:27:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1729787275;
	bh=Rrc56uTnfRNdC1bewUry4Xfnxz5KZpPPiUjQQRJFyU4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=aZbVPBF+axigjMKsw1msqICxBnjDWBRgdI0ct3T7Kf898m8kTzL9UA31mp7dLLOSJ
	 XQ+g2sskTIVJyy2D6A2dXk/UjRYJdzh9N93DjRLWJ26LHk3xkGPAy6W90rYsfsqPEr
	 cQdcwBMYVVqDWYQLGCFWkS6heSDbavxlERDs9lgI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 731B41287956;
	Thu, 24 Oct 2024 12:27:51 -0400 (EDT)
Message-ID: <f90bba20e86dac698472d686be7ec565736adca0.camel@HansenPartnership.com>
Subject: Re: linux: Goodbye from a Linux community volunteer
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Serge Semin
 <fancer.lancer@gmail.com>,  Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
 ntb@lists.linux.dev, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Kory Maincent
 <kory.maincent@bootlin.com>,  Cai Huoqing <cai.huoqing@linux.dev>,
 dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 linux-spi@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
 linux-ide@vger.kernel.org, "paulburton@kernel.org" <paulburton@kernel.org>,
  Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Arnd Bergmann
 <arnd@arndb.de>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,  Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Yoshihiro Shimoda
 <yoshihiro.shimoda.uh@renesas.com>, linux-pci <linux-pci@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <olteanv@gmail.com>, Kelvin Cheung
 <keguang.zhang@gmail.com>, Yanteng Si <siyanteng@loongson.cn>, 
 netdev@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
 linux-hwmon@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
 linux-edac@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  linux-serial@vger.kernel.org
Cc: Andrew Halaney <ajhalaney@gmail.com>, Nikita Travkin <nikita@trvn.ru>, 
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Alexander Shiyan
 <shc_work@mail.ru>, Dmitry Kozlov <xeb@mail.ru>,  Sergey Shtylyov
 <s.shtylyov@omp.ru>, Evgeniy Dushistov <dushistov@mail.ru>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Sergio Paracuellos
 <sergio.paracuellos@gmail.com>,  Nikita Shubin <nikita.shubin@maquefel.me>,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 24 Oct 2024 12:27:49 -0400
In-Reply-To: <753d203a-a008-4cd3-b053-38b5ce31281b@app.fastmail.com>
References: 
	<2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
	 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
	 <753d203a-a008-4cd3-b053-38b5ce31281b@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-10-24 at 16:59 +0100, Jiaxun Yang wrote:
> 
> 
> 在2024年10月24日十月 下午3:50，James Bottomley写道：
> > On Thu, 2024-10-24 at 07:27 +0300, Serge Semin wrote:
> > > Hello Linux-kernel community,
> [...]
> 
> Hi James,
> 
> Sorry to chime in here, and thanks for making things clear.
> 
> However, I have some questions regarding this statement, please see
> below:
> 
> > Please accept all of our apologies for the way this was handled.  A
> > summary of the legal advice the kernel is operating under is
> 
> In what capacity this statement was made, i.e, who is "our" here and
> "we" below? Are you representing any formal group in this case?

It's Linux, so no official capacity at all.  However, I am expressing
the views of a number of people I talked to but it's not fair of me to
name them.

> >    If your company is on the U.S. OFAC SDN lists, subject to an
> > OFAC
> >    sanctions program, or owned/controlled by a company on the list,
> > our
> >    ability to collaborate with you will be subject to restrictions,
> > and
> >    you cannot be in the MAINTAINERS file.
> > 
> > Anyone who wishes to can query the list here:
> > 
> > https://sanctionssearch.ofac.treas.gov/
> 
> I did a quick search and found the following entry:
> 
> HUAWEI TECHNOLOGIES CO., LTD. Under CMIC-EO13959 sanction program.
> 
> Although it's a Non-SDN sanction, it can still be interpreted as
> "subject to an OFAC sanctions program".
> 
> How should we handle it?

A big chunk of the reason it's taken so long just to get the above is
that the Lawyers (of which I'm not one) are still discussing the
specifics and will produce a much longer policy document later, so they
don't want to be drawn into questions like this.  However, my non-
legal-advice rule of thumb that I'm applying until I hear otherwise is
not on the SDN list, not a problem.

James




