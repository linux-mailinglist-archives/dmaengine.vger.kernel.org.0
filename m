Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 796711A08A9
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2020 09:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgDGHwL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Apr 2020 03:52:11 -0400
Received: from smaract.com ([82.165.73.54]:45402 "EHLO smaract.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgDGHwL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 Apr 2020 03:52:11 -0400
Received: from mx1.smaract.de (staticdsl-213-168-205-127.ewe-ip-backbone.de [213.168.205.127])
        by smaract.com (Postfix) with ESMTPSA id 934FCA001F;
        Tue,  7 Apr 2020 07:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smaract.com;
        s=default; t=1586245929;
        bh=18RaO8o/Wc3RAcIm0cRWdyK1KYdxT/RX5Q4badXMT7I=; l=722;
        h=From:To:Subject;
        b=TQV1SlXCfb1m6lTDvpTpnTA3ie2yrGD1kEae+IZj5CZn/D4sfP107WloxUNd5DXRD
         zV3mYh3wTVuqJ+7wdmAjpz3fklGHcBqv5zjK5v6v/VuFVDfS7ULQpm4LppbUBtqf7g
         os7gDYeoHOrBBdhs4pYlUaJhs2eahT7KJsthANRs=
Authentication-Results: smaract.com;
        spf=pass (sender IP is 213.168.205.127) smtp.mailfrom=vonohr@smaract.com smtp.helo=mx1.smaract.de
Received-SPF: pass (smaract.com: connection is authenticated)
From:   Sebastian von Ohr <vonohr@smaract.com>
To:     Radhey Shyam Pandey <radheys@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        Michal Simek <michals@xilinx.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: xilinx_dma: Add missing check for empty list
Thread-Topic: [PATCH] dmaengine: xilinx_dma: Add missing check for empty list
Thread-Index: AQHV8VxxdjMBtKwDjUiUwfzZyHoPo6g7hG2AgAAGXQCAMfPDcA==
Date:   Tue, 7 Apr 2020 07:52:08 +0000
Message-ID: <c12c2321f9d5407698b9992b9a375966@smaract.com>
References: <20200303130518.333-1-vonohr@smaract.com>
 <20200306133427.GG4148@vkoul-mobl>
 <CH2PR02MB7000C592992EEFBFB01D5735C7E30@CH2PR02MB7000.namprd02.prod.outlook.com>
In-Reply-To: <CH2PR02MB7000C592992EEFBFB01D5735C7E30@CH2PR02MB7000.namprd02.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-PPP-Message-ID: <158624592968.56494.16914672032200698300@smaract.com>
X-PPP-Vhost: mario.smaract.com
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Radhey Shyam Pandey [mailto:radheys@xilinx.com]
> Sent: Friday, March 6, 2020 2:57 PM
> To: Vinod Koul <vkoul@kernel.org>; Sebastian von Ohr
> <vonohr@smaract.com>; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>; Michal Simek <michals@xilinx.com>
> Cc: dmaengine@vger.kernel.org
> Subject: RE: [PATCH] dmaengine: xilinx_dma: Add missing check for empty
> list
>=20
> Sure, we will test it. Changes look fine.  Though had a question in mind,
> for a generic fix to this problem, should we make locking mandatory for
> all cookie helper functions? Or is there any limitation?

Any progress on the testing? If you need help reproducing the issue please =
let me know.
