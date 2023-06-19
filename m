Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11615735D88
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jun 2023 20:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjFSSlO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Jun 2023 14:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjFSSlN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Jun 2023 14:41:13 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893CFE6E;
        Mon, 19 Jun 2023 11:41:09 -0700 (PDT)
X-GND-Sasl: kory.maincent@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687200068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bdfkvwi5YASMPpEuIoUnF7CVkCeJJHGf2/I6JPyJWQU=;
        b=cOrV+fPZMJsmIOrJxWCq30GEPUpalF7Ug4i14220zLMGZOsWLxF/XsoIG2qn5zmhVjdkVN
        jF3+0bjWITwlFZYaJejasJZeUWPTsA2Q3sKScPC97Y2Noxt9l2CM+LkorzNkixXcorxWAd
        9cv3emDLNcNtK68YleAjJ/8RdEpMdrU3oPVV7x6RAmLpyBO8BlHKkB99rpQeeinn4WJjnP
        I+5J2W5NTaSuplTCeCoNrF1S9KM5QhlH/Cc4X6HNGo/V7+rgHOHDZpeOyKx7qKShn4w55M
        OuFT/cb3STiJBLyfM+RgMJ40bNKgi2THotxhyanA6gkpOMJ3Wo87FfD2VWEXsQ==
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E17CD20002;
        Mon, 19 Jun 2023 18:41:06 +0000 (UTC)
Date:   Mon, 19 Jun 2023 20:41:05 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 5/9] dmaengine: dw-edma: HDMA: Fix possible race
 condition in remote setup
Message-ID: <20230619204105.620f87e6@kmaincent-XPS-13-7390>
In-Reply-To: <20230619171550.3iyujmbre3dpe5oq@mobilestation.baikal.int>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
        <20230609081654.330857-6-kory.maincent@bootlin.com>
        <20230619171550.3iyujmbre3dpe5oq@mobilestation.baikal.int>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 19 Jun 2023 20:15:50 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> On Fri, Jun 09, 2023 at 10:16:50AM +0200, K=C3=B6ry Maincent wrote:
> > From: Kory Maincent <kory.maincent@bootlin.com>
> >=20
> > When writing the linked list elements and pointer the control need to be
> > written at the end. If the control is written and the SAR and DAR not
> > stored we could face a race condition.
> >=20
> > Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> Once again. Is this a hypothetical bug or have you actually
> experienced the denoted problem? If you do please describe the
> circumstances, give more details. Otherwise it sounds weird. Here is
> why.
>=20
> DW eDMA HW manual states that the control LL DWORD is indeed supposed
> to be written after the rest of the descriptor DWORDs are written. But
> AFAICS it's only relevant for the LL tree entries recycling. Current
> DW eDMA driver design doesn't truly implement that pattern. Instead
> the DMA transfer is halted at the end of the chunk. Then the engine is
> recharged with the next chunk and execution is started over. So the
> runtime recycling isn't implemented (alas) for which the CB flag of
> the control DWORD needs to be updated only after the rest of the LLI
> fields.

This one is only hypothetical. It appears to me that writing the control
after the configuration of sar and dar is more relevant to prevent race iss=
ues
and should be the usual coding choice. Also you are right saying that it wi=
ll
be relevant only for the LL tree entries recycling.
Simple question from non DMA expert: isn't cyclic DMA mode recycle the LL t=
ree
entries?=20

>=20
> If you described a hypothetical problem then it would be ok to accept
> the change for the sake of consistency but I would have dropped the
> Fixes tag and updated the patch description with more details of the
> race condition you are talking about.

Alright, I will do that.

K=C3=B6ry
