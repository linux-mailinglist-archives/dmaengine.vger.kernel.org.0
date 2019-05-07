Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 038B916162
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 11:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfEGJsx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 05:48:53 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:60424 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbfEGJsw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 May 2019 05:48:52 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CBA35C0215;
        Tue,  7 May 2019 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557222526; bh=2/BtsFeWy0vYI3d4XxhOkoQsDf1SDfNEc8LF8uFH4HM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KQe5JSStKzOLfwNJwlQHpC17R0VQ8o6QkFCpQu0TIUpEa7WJxxaeyEpy3NlsENNrs
         D5PsZSauak/aLGdd2AhHrelPXN5QBqcQ7y+D63H0mV8NwyWEKTl9+K0dkobj+ThCmo
         QnHa0ojcOJoqWu8ZXfB7YvNRu1EUPx+s7ky55FZA69yyNaZYqTYiG/j25bWEuJdLMQ
         2POfh8G6yz9yShTLgCXSZ4XFnaAuKu2HFz07LowrknuPQTtRU50/17d7JezTQo9k5F
         EnrigxTeHq2xuIgFQjK1Y5nDyZfl5G4H1Ez+RxHDCr6lzbGhIac0l2Kcx31lL7ZopF
         0rA6CphfdIs6w==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id EA10EA005D;
        Tue,  7 May 2019 09:48:50 +0000 (UTC)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 7 May 2019 02:48:50 -0700
Received: from DE02WEMBXA.internal.synopsys.com ([fe80::a014:7216:77d:d55c])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 7 May 2019 11:48:48 +0200
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: RE: [RFC v6 3/6] dmaengine: Add Synopsys eDMA IP version 0 debugfs
 support
Thread-Topic: [RFC v6 3/6] dmaengine: Add Synopsys eDMA IP version 0 debugfs
 support
Thread-Index: AQHU+gKjY3BZ+ptMNEe3UM3QKN3a8aZd8uoAgAByHKCAAKwdAIAAY+IQ
Date:   Tue, 7 May 2019 09:48:48 +0000
Message-ID: <305100E33629484CBB767107E4246BBB0A238E47@de02wembxa.internal.synopsys.com>
References: <cover.1556043127.git.gustavo.pimentel@synopsys.com>
 <ba56a34f11c4bb699079946ca51bb11244ac713e.1556043127.git.gustavo.pimentel@synopsys.com>
 <20190506120710.GG3845@vkoul-mobl.Dlink>
 <305100E33629484CBB767107E4246BBB0A2386A1@de02wembxa.internal.synopsys.com>
 <20190507051136.GB16052@vkoul-mobl>
In-Reply-To: <20190507051136.GB16052@vkoul-mobl>
Accept-Language: pt-PT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTRkYjg4MzgxLTcwYWQtMTFlOS05ODgxLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw0ZGI4ODM4Mi03MGFkLTExZTktOTg4MS1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjM1ODEiIHQ9IjEzMjAxNjk2MTI2ODI2?=
 =?us-ascii?Q?MDczMCIgaD0iL3hOWkFzK3RPRWFTNW42RU5ZYkNNd0twVWtRPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?Nm43Z1F1Z1RWQVhJcVlxZVVtZW5tY2lwaXA1U1o2ZVlPQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFGdGJCcHdBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
 =?us-ascii?Q?QmhBRzRBWXdCbEFGOEFjQUJzQUdFQWJnQnVBR2tBYmdCbkFGOEFkd0JoQUhR?=
 =?us-ascii?Q?QVpRQnlBRzBBWVFCeUFHc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtBWHdC?=
 =?us-ascii?Q?d0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCbkFHWUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFiZ0Js?=
 =?us-ascii?Q?QUhJQWN3QmZBSE1BWVFCdEFITUFkUUJ1QUdjQVh3QmpBRzhBYmdCbUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1BRzhB?=
 =?us-ascii?Q?ZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWN3QmhB?=
 =?us-ascii?Q?RzBBY3dCMUFHNEFad0JmQUhJQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FY?=
 =?us-ascii?Q?d0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0J6QUcwQWFRQmpBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJn?=
 =?us-ascii?Q?QmxBSElBY3dCZkFITUFkQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFH?=
 =?us-ascii?Q?OEFkUUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBZEFC?=
 =?us-ascii?Q?ekFHMEFZd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhr?=
 =?us-ascii?Q?QVh3QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QjFBRzBBWXdBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQVp3QjBBSE1BWHdCd0FISUFid0JrQUhVQVl3QjBBRjhB?=
 =?us-ascii?Q?ZEFCeUFHRUFhUUJ1QUdrQWJnQm5BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6?=
 =?us-ascii?Q?QUdFQWJBQmxBSE1BWHdCaEFHTUFZd0J2QUhVQWJnQjBBRjhBY0FCc0FHRUFi?=
 =?us-ascii?Q?Z0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFITUFZUUJzQUdVQWN3QmZB?=
 =?us-ascii?Q?SEVBZFFCdkFIUUFaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBY3dCdUFIQUFjd0JmQUd3QWFRQmpBR1VBYmdCekFH?=
 =?us-ascii?Q?VUFYd0IwQUdVQWNnQnRBRjhBTVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QnpBRzRBY0FCekFGOEFiQUJwQUdNQVpRQnVBSE1BWlFCZkFIUUFaUUJ5QUcw?=
 =?us-ascii?Q?QVh3QnpBSFFBZFFCa0FHVUFiZ0IwQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhZQVp3QmZBR3NBWlFC?=
 =?us-ascii?Q?NUFIY0Fid0J5QUdRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFBPSIvPjwvbWV0YT4=3D?=
x-originating-ip: [10.107.25.131]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 7, 2019 at 6:11:36, Vinod Koul <vkoul@kernel.org> wrote:

> On 06-05-19, 17:09, Gustavo Pimentel wrote:
> > Hi Vinod,
> >=20
> > On Mon, May 6, 2019 at 13:7:10, Vinod Koul <vkoul@kernel.org> wrote:
> >=20
> > > On 23-04-19, 20:30, Gustavo Pimentel wrote:
> > >=20
> > > >  int dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip)
> > > >  {
> > > > -	return 0;
> > > > +	return dw_edma_v0_debugfs_on(chip);
> > >=20
> > > who calls this?
> >=20
> > The main driver. This was done like this for 2 reasons:
> > 1) To not break the patch #1 compilation
> > 2) Since the code it's to extensive, I decided to break it in another=20
> > patch.
>=20
> Hmm I guess I missed that one. I was actually looking at usage and not
> questioning split :)
>=20
> > > > +static int dw_edma_debugfs_u32_get(void *data, u64 *val)
> > > > +{
> > > > +	if (dw->mode =3D=3D EDMA_MODE_LEGACY &&
> > > > +	    data >=3D (void *)&regs->type.legacy.ch) {
> > > > +		void *ptr =3D (void *)&regs->type.legacy.ch;
> > > > +		u32 viewport_sel =3D 0;
> > > > +		unsigned long flags;
> > > > +		u16 ch;
> > > > +
> > > > +		for (ch =3D 0; ch < dw->wr_ch_cnt; ch++)
> > > > +			if (lim[0][ch].start >=3D data && data < lim[0][ch].end) {
> > > > +				ptr +=3D (data - lim[0][ch].start);
> > > > +				goto legacy_sel_wr;
> > > > +			}
> > > > +
> > > > +		for (ch =3D 0; ch < dw->rd_ch_cnt; ch++)
> > > > +			if (lim[1][ch].start >=3D data && data < lim[1][ch].end) {
> > > > +				ptr +=3D (data - lim[1][ch].start);
> > > > +				goto legacy_sel_rd;
> > > > +			}
> > > > +
> > > > +		return 0;
> > > > +legacy_sel_rd:
> > > > +		viewport_sel =3D BIT(31);
> > > > +legacy_sel_wr:
> > > > +		viewport_sel |=3D FIELD_PREP(EDMA_V0_VIEWPORT_MASK, ch);
> > > > +
> > > > +		raw_spin_lock_irqsave(&dw->lock, flags);
> > > > +
> > > > +		writel(viewport_sel, &regs->type.legacy.viewport_sel);
> > > > +		*val =3D readl((u32 *)ptr);
> > >=20
> > > why do you need the cast?
> >=20
> > I can't tell from my head, but I think checkpatch or some code analysis=
=20
> > tool was complaining about not having that.
>=20
> ptr is void, so there is no need for casts to or away from void.
>=20
> > > > +static int dw_edma_debugfs_regs(void)
> > > > +{
> > > > +	const struct debugfs_entries debugfs_regs[] =3D {
> > > > +		REGISTER(ctrl_data_arb_prior),
> > > > +		REGISTER(ctrl),
> > > > +	};
> > > > +	struct dentry *regs_dir;
> > > > +	int nr_entries, err;
> > > > +
> > > > +	regs_dir =3D debugfs_create_dir(REGISTERS_STR, base_dir);
> > > > +	if (!regs_dir)
> > > > +		return -EPERM;
> > > > +
> > > > +	nr_entries =3D ARRAY_SIZE(debugfs_regs);
> > > > +	err =3D dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs=
_dir);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	err =3D dw_edma_debugfs_regs_wr(regs_dir);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	err =3D dw_edma_debugfs_regs_rd(regs_dir);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	return 0;
> > >=20
> > > single return err would suffice right?
> >=20
> > By looking now to this code, I decided to remove the err variable and=20
> > perform the if immediately on the function, if the result is different=
=20
> > from 0 it goes directly to a return -EPERM.=20
>=20
> And one more things, we do not need to check errors on debugfs calls,
> and if it fails it fails...

Ok, makes sense. I'll remove all return validation relatively to debugfs=20
calls.

>=20
> --=20
> ~Vinod
