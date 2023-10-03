Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AD87B6D3A
	for <lists+dmaengine@lfdr.de>; Tue,  3 Oct 2023 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjJCPej (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 11:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjJCPei (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 11:34:38 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0EB83;
        Tue,  3 Oct 2023 08:34:35 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C36EBC000A;
        Tue,  3 Oct 2023 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696347273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kVHRMZOFGQbyhQ84iZ/Y4uKPhQjVQLIbgBxP6GHPHRY=;
        b=piGjrDRThUkU20YX++x3hInugNyWUvr8hKVcyGw27IDHLwC5psgzkydvNN+q1SfVtDS4Ft
        Nph0jn85VDs+c4uyvC8vXDZ9z49ujTP7ptwntCcYkOACLoW6sGxCsQDo18KbhOlnFoZvj9
        zqEEm5I9sOx7PCiGJAh3wTnb/Q5nwrhCLA6Raf1tq7lkde4PjNpehS2okf8TjchQ4FKOLQ
        AFM4oAvkqkNBqCUni6Z4aPfrbIL/9tbkr2GZF/qW0a8oNEU2Aasdf5jiKuEBs5MAhZEZA5
        Xu4AvsZBQBi4YFwL6gIs2cmcyvii1eV7G1hBsK/4Qi8D3tnY7yAvLIhpVz1nRw==
Date:   Tue, 3 Oct 2023 17:34:32 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 4/5] dmaengine: dw-edma: HDMA: Add sync read before
 starting the DMA transfer in remote setup
Message-ID: <20231003173432.18480fa1@kmaincent-XPS-13-7390>
In-Reply-To: <2yh3lus7qqhvewva6dr4p2g7azbgov4ls57xvzefbrw24h2t7m@cbx26pwj73zn>
References: <m6mxnmppc7hybs2tz57anoxq6afu2x63tigjya2eooaninpe4h@ayupt4qauq7v>
        <20231003121542.3139696-1-kory.maincent@bootlin.com>
        <2yh3lus7qqhvewva6dr4p2g7azbgov4ls57xvzefbrw24h2t7m@cbx26pwj73zn>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 3 Oct 2023 18:20:23 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> On Tue, Oct 03, 2023 at 02:15:42PM +0200, K=C3=B6ry Maincent wrote:
> > From: Kory Maincent <kory.maincent@bootlin.com>
> >=20
> > The Linked list element and pointer are not stored in the same memory as
> > the HDMA controller register. If the doorbell register is toggled before
> > the full write of the linked list a race condition error can appears.
> > In remote setup we can only use a readl to the memory to assured the fu=
ll
> > write has occurred.
> >=20
> > Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >=20
> > Changes in v2:
> > - Move the sync read in a function.
> > - Add commments =20
>=20
> Note you need to resubmit the entire series if any of its part has
> changed. So please add these patches to your patchset (in place of the
> 4/5 and 5/5 patches I commented) and resend it as v3.

Alright.
Should I wait for Cai's response for patch 1/5 before sending v3. He seems =
to
never having woken up in our discussions.
