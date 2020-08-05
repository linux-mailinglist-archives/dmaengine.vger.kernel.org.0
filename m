Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761C923CFAC
	for <lists+dmaengine@lfdr.de>; Wed,  5 Aug 2020 21:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgHER36 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Aug 2020 13:29:58 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52026 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgHER1q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Aug 2020 13:27:46 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 075BQODj042353;
        Wed, 5 Aug 2020 06:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596626784;
        bh=ptD3hGzWwT8Vq2gSquJN4k9oJHMA8CvoI0Kiq0So7lw=;
        h=From:To:CC:Subject:Date;
        b=rWRwla7T/new3KgGWmbnNQqJZngYGytA2IVU4/3oUmp0CNNi6zALaUaoK+GEEBGSH
         x3lyNisfVC4liC0+qf/jb4j14wFX8WYk4NxXicaL0YvVy0sz9ItDBRWKd/q1TP5WGG
         GAOx6UqOG3Q0NOkJV5aWqDRAjLDe6RhEU55fQ6vI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 075BQOJE114460;
        Wed, 5 Aug 2020 06:26:24 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 5 Aug
 2020 06:26:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 5 Aug 2020 06:26:23 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 075BQL5i053178;
        Wed, 5 Aug 2020 06:26:22 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <ssantosh@kernel.org>, <santosh.shilimkar@oracle.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <grygorii.strashko@ti.com>,
        <linux-kernel@vger.kernel.org>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH] dmaengine: ti: k3-udma-glue: Fix parameters for rx ring pair request
Date:   Wed, 5 Aug 2020 14:27:46 +0300
Message-ID: <20200805112746.15475-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


