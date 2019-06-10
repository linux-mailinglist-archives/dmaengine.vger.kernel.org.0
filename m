Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2553B25A
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jun 2019 11:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389024AbfFJJmt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jun 2019 05:42:49 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34800 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388033AbfFJJmt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jun 2019 05:42:49 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5A9gaKj000807;
        Mon, 10 Jun 2019 04:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560159757;
        bh=2oO3Xg8fMHPjnwmVSMmpy0PpqsvBXBoMDQCicgKTfPk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UwE6KsIJ1ugdmhMf4suETeKqxQlhSDaB1wwqcC739zqPIx258ODERDvuCt9ZXYacN
         /+yAxJdgvZNMfKhaqjRcVOCoIytn30L32AfZq+EuuyOqvxGKquX4Z6SrdhlfKCf+tg
         Y7/MCKLvymzo6iXJRJvQaahrTT6RybKMvHULjqjI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5A9gaIB000883
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Jun 2019 04:42:36 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 10
 Jun 2019 04:42:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 10 Jun 2019 04:42:36 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5A9gWMT067517;
        Mon, 10 Jun 2019 04:42:33 -0500
Subject: Re: [PATCH v1.1] firmware: ti_sci: Add resource management APIs for
 ringacc, psi-l and udma
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>
References: <20190506123456.6777-2-peter.ujfalusi@ti.com>
 <20190610091856.25502-1-peter.ujfalusi@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <636f599a-cefa-ce70-d0ae-b5244edf14b2@ti.com>
Date:   Mon, 10 Jun 2019 15:11:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610091856.25502-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/06/19 2:48 PM, Peter Ujfalusi wrote:
> Configuration of NAVSS resource, like rings, UDMAP channels, flows
> and PSI-L thread management need to be done via TISCI.
> 
> Add the needed structures and functions for NAVSS resource configuration of
> the following:
> Rings from Ring Accelerator
> PSI-L thread management
> UDMAP tchan, rchan and rflow configuration.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh
