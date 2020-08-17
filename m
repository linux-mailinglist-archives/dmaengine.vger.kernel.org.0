Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27357246591
	for <lists+dmaengine@lfdr.de>; Mon, 17 Aug 2020 13:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgHQLiS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 07:38:18 -0400
Received: from mail2.skidata.com ([91.230.2.91]:5503 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgHQLiQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Aug 2020 07:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1597664295; x=1629200295;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qAiSySTl/y8QrdoOwS73hqC2vZPrIK22GvC7HIEK8Sw=;
  b=LP63tE3J/JW2ErnnxJAehAh0T7+LeTm3GauBDpY8jJWSpOmTCkiomLNt
   xSxIHMFnQNyovd0/2aHVfx4HJGyc+QedBfLCAgswXz7VzO6mMQRdTtGs3
   CHLHba95AO6BrIzEjGI1BwSgMTq11LnJi6zHCBbG3HVs33XolXG1MvgaG
   xNSPMxFp6O40rhqzgCJQtyxBBLCjqqnmMOH7w8prsfRyVSRGufSbKxP5c
   KB9HFM5hBOdG2S1GdZzsnitaBtSVzHif/HodY3OHO4mCuGzxLdaJnNiir
   NeKNBwCD4J4GYVz/0+uC3Z4yV9pgJ3k7Ov7SICIYFuVuJItxfJ3bhDllP
   Q==;
IronPort-SDR: r14hO/kLklIsGQ2dnpEN7qM09P2f2aF1EjhAlxzmSMcuqfvXFBRe+N2g2GbNAQy6RBnH6mvub4
 G9CzTCq5/0Xu34vgrQoODE4XvobffdAgUcNAoI/Wd3UL6Jq51FS5mK4HdyazyQntye83cu6C1d
 Utxs08P5rh1ovPmRJnbqt32sNVRq/vBpgr26ga+RPc5pxsLbfheQqpxpsN6+Av0kB6MiwftAt7
 /fB6w62Tw9zJn1oFUf2wPuRXpstyhH7KMAs9dQhCYg8DlQFi2903uhUeTmOramaYOuZ2OpH0lA
 PAs=
X-IronPort-AV: E=Sophos;i="5.76,322,1592863200"; 
   d="scan'208";a="2642801"
From:   Benjamin Bara - SKIDATA <Benjamin.Bara@skidata.com>
To:     Robin Gong <yibin.gong@nxp.com>
CC:     "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Richard Leitner - SKIDATA <Richard.Leitner@skidata.com>
Subject: RE: pcm|dmaengine|imx-sdma race condition on i.MX6
Thread-Topic: pcm|dmaengine|imx-sdma race condition on i.MX6
Thread-Index: AQHWcWQZKYOChL0mPkuCFeZyDJy6mKk3KiiAgABS1/CABG6hAIAARo2Q
Date:   Mon, 17 Aug 2020 11:38:10 +0000
Message-ID: <a64ae27d9f1348ecae6adc74969cc88c@skidata.com>
References: <20200813112258.GA327172@pcleri>
 <VE1PR04MB6638EE5BDBE2C65FF50B7DB889400@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <61498763c60e488a825e8dd270732b62@skidata.com>
 <VE1PR04MB6638AC2A3AE852C3047E7B97895F0@VE1PR04MB6638.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB6638AC2A3AE852C3047E7B97895F0@VE1PR04MB6638.eurprd04.prod.outlook.com>
Accept-Language: en-US, de-AT
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.111.252]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Robin Gong <yibin.gong@nxp.com>
> Sent: Montag, 17. August 2020 11:23
> busy_wait is not good I think, would you please have a try with the attac=
hed patch
> which is based on https://lkml.org/lkml/2020/8/11/111? The basic idea is
> to keep the freed descriptor into another list for freeing in later termi=
nate_worker
> instead of freeing directly all in terminate_worker by vchan_get_all_desc=
riptors
> which may break next descriptor coming soon

The idea sounds good, but with this attempt we are still not sure that the =
1ms
(the ultimate reason why this is a problem) is awaited between DMA disablin=
g and
re-enabling.

If we are allowed to leave the atomic PCM context on each trigger, synchron=
ize the DMA and then
enter it back again, everything is fine.
This might be the most performant and elegant solution.
However, since we are in an atomic context for a reason, it might not be wa=
nted by the PCM system
that the DMA termination completion of the previous context happens within =
the next call,
but we are not sure about that.
In this case, a busy wait is not a good solution, but a necessary one,
or at least the only valid solution we are aware of.

Anyhow, based on my understanding, either the start or the stop trigger has=
 to wait the 1ms
(or whats left of it).

