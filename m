Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58F526C4CD
	for <lists+dmaengine@lfdr.de>; Wed, 16 Sep 2020 18:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIPQAo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Sep 2020 12:00:44 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44506 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgIPQA0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Sep 2020 12:00:26 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08GCA4Sx019540;
        Wed, 16 Sep 2020 07:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600258204;
        bh=eYVjrXG7n0dNY1scg668IOD4Bg6anWGa0/3eL4ICiuA=;
        h=From:To:CC:Subject:Date;
        b=p4Oey2wg+4Z3q3vC+mXmJl+lXqYEeuIAOduqwRFU9SXwkHGVjAa525NOhVjyV90+3
         3T/Chw/0FoZh3LIVGFDF6QrOrKajRBwH4OKwTypo2+N3HPlG1qso1RPeVqMpVr75pi
         lEdbmiOsGf64kOyrbbDdxbiU+87AxqwT2RxwR0U4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GCA4xd097182;
        Wed, 16 Sep 2020 07:10:04 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Sep 2020 07:10:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Sep 2020 07:10:04 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GCA3c3089115;
        Wed, 16 Sep 2020 07:10:03 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        <dmaengine@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2] dmaengine: ti: k3-udma-glue: fix channel enable functions
Date:   Wed, 16 Sep 2020 15:09:55 +0300
Message-ID: <20200916120955.7963-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


