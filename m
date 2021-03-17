Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E79833E63C
	for <lists+dmaengine@lfdr.de>; Wed, 17 Mar 2021 02:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhCQBft (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Mar 2021 21:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhCQBfs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Mar 2021 21:35:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F4F364E76;
        Wed, 17 Mar 2021 01:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615944948;
        bh=wfVsG34NpnkPgDNvkfeM6rHhymxXjOqDbCNsoIlma9s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YIqypZavA3LNYBIPc1EreM/QDPJFqyeB+Xdvbxq1wCfvXWZPydjiMAe93cDQh4+eP
         gNfTj7D7paWO1O1uNQp5ZMkVeXR4tM+BdMTxVPf7ZHJgcbbQYFnHQUnkS0MbaK6aBI
         1lYIEDicUaOY6H5SCN9STWjcGvWH9N6oQxERx16WPgjZ+GZOtcqa4v8Cv9dr0er7bD
         zXQaQIScBIieUeVWBkI/izQUVGrDePmYFQnkIK9ggZdGQlXuXgCXkOD/lXjuMFUPAa
         ElY2b6rfq+i9r07KPQ0xNtZvpLo2I2UF9Ks3/hgj/xLiUs+4v6dyI4uRkLJEViE+go
         QGH6AH4BQz8Jg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210316194918.3528417-1-robh@kernel.org>
References: <20210316194918.3528417-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Clean-up undocumented compatible strings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Vinod Koul <vkoul@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-i3c@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Date:   Tue, 16 Mar 2021 18:35:46 -0700
Message-ID: <161594494696.1478170.13888306623342465859@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Quoting Rob Herring (2021-03-16 12:49:18)
> Adding checks for undocumented compatible strings reveals a bunch of
> warnings in the DT binding examples. Fix the cases which are typos, just
> a mismatch between the schema and the example, or aren't documented at al=
l.
> In a couple of cases, fixing the compatible revealed some schema errors
> which are fixed.
>=20
> There's a bunch of others remaining after this which have bindings, but
> those aren't converted to schema yet.
>=20
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-clk@vger.kernel.org
> Cc: dmaengine@vger.kernel.org
> Cc: linux-i3c@lists.infradead.org
> Cc: linux-iio@vger.kernel.org
> Cc: linux-leds@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
