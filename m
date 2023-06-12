Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB9E72BB99
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjFLJEH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFLJDn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:03:43 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627C64221;
        Mon, 12 Jun 2023 01:59:46 -0700 (PDT)
X-GND-Sasl: kory.maincent@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686560385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cO14zcOxiDtyCfggm0ZmyKFEk1cAqg+L0MJg9mmmLXA=;
        b=EAx7dXfxNEBqD4fGyCMO1OXqwqMZa1zGGZfX4BGkt1A0KO4KCXzb2UlSxieMdfU7CZmtux
        PVAbpRpZWubf36NUaKNoOBEwbrB+3FKXxKoGJTBuieInszGut2lOxnPDuup6EVFHyLAbG9
        fpBu4UlapEYEM3UFPC1DiJkUifjsAGpvQ47wkFWOi2JADQjt2/pSwkUkEzV7w39FWENkMr
        xBIKLn7ZdBtR4F/2KjsLt9HVZGxpkOHOaEhQUlu4gS0j/UAMXmv3hNERO7YGrZuJC3jABu
        l9qsINOpjW9Fu7edJrWFgmYiGjhSQziqoeUP4Wv7FrGWDfXv3euhlPf5TYijMQ==
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97657E000F;
        Mon, 12 Jun 2023 08:59:44 +0000 (UTC)
Date:   Mon, 12 Jun 2023 10:59:42 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 0/9] Fix support of dw-edma HDMA NATIVE IP in remote
 setup
Message-ID: <20230612105942.039b6fc0@kmaincent-XPS-13-7390>
In-Reply-To: <20230609081654.330857-1-kory.maincent@bootlin.com>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri,  9 Jun 2023 10:16:45 +0200
K=C3=B6ry Maincent <kory.maincent@bootlin.com> wrote:

> From: Kory Maincent <kory.maincent@bootlin.com>
>=20
> This patch series fix the support of dw-edma HDMA NATIVE IP.
> I can only test it in remote HDMA IP setup with single dma transfer, but
> with these fixes it works properly.
>=20
> Few fixes has also been added for eDMA version. Similarly to HDMA I have
> tested only eDMA in remote setup.

FYI it seems several patches of this series has been categorized as spam.
I think it is because the code of these patches are quite similar.

K=C3=B6ry
