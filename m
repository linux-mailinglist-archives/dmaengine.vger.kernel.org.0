Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621262143E6
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jul 2020 05:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgGDDpM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 23:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgGDDpM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Jul 2020 23:45:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B6CC061794;
        Fri,  3 Jul 2020 20:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=RjgXbItONDI8qoKZoagX/7fm2XOCDVB41PDHOzajmYk=; b=RWNe5fwbC3uETb+vlA25w47G3W
        81y378w8gWI/l1I3BPLGTGJicfvdaYVSHZlWHL4Hr274m/Gu+9IT0kTIyL9CibvdIjGBGjA0sEIg2
        zPhQ7y4YxWIMVJNCAjAtZPQxKkCok68tVHKhYM/AWFDo8STqJT6VWg8wFXfdJOdojDYsKxqN2zWGO
        ILNhDg2rOINWSh94+fSvNzVs0SACUZiQvqnxJgiCJ2jzDTuI9P5RBHjoZOnCRuAiVODwJ3OIB3HUC
        x4PHuDEI9filMB0QaqnSXiLe2h3crPRb65DfVRIkCXMmbrrFyBqlIQC0wi3nSpCE1f7DqmZJiG6je
        HtGhnLOw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrZ6y-0001Xb-Bk; Sat, 04 Jul 2020 03:45:09 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org,
        linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
Subject: [PATCH 00/17] Documentation/driver-api: eliminate duplicated words
Date:   Fri,  3 Jul 2020 20:44:45 -0700
Message-Id: <20200704034502.17199-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove occurrences of duplicated words in Documentation/driver-api/.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: linux-nvdimm@lists.01.org
Cc: linux-usb@vger.kernel.org
Cc: Eli Billauer <eli.billauer@gmail.com>


 Documentation/driver-api/dmaengine/provider.rst        |    2 +-
 Documentation/driver-api/driver-model/platform.rst     |    2 +-
 Documentation/driver-api/firmware/built-in-fw.rst      |    2 +-
 Documentation/driver-api/firmware/direct-fs-lookup.rst |    2 +-
 Documentation/driver-api/firmware/firmware_cache.rst   |    2 +-
 Documentation/driver-api/firmware/request_firmware.rst |    2 +-
 Documentation/driver-api/generic-counter.rst           |    2 +-
 Documentation/driver-api/iio/buffers.rst               |    2 +-
 Documentation/driver-api/media/cec-core.rst            |    2 +-
 Documentation/driver-api/media/dtv-frontend.rst        |    6 +++---
 Documentation/driver-api/media/v4l2-controls.rst       |    4 ++--
 Documentation/driver-api/media/v4l2-dev.rst            |    2 +-
 Documentation/driver-api/ntb.rst                       |    2 +-
 Documentation/driver-api/nvdimm/nvdimm.rst             |    2 +-
 Documentation/driver-api/uio-howto.rst                 |    2 +-
 Documentation/driver-api/usb/URB.rst                   |    2 +-
 Documentation/driver-api/xillybus.rst                  |    2 +-
 17 files changed, 20 insertions(+), 20 deletions(-)
