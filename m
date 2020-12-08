Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823FD2D2A01
	for <lists+dmaengine@lfdr.de>; Tue,  8 Dec 2020 12:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgLHLxu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Dec 2020 06:53:50 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38776 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgLHLxu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Dec 2020 06:53:50 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B8Bq8k7055935;
        Tue, 8 Dec 2020 05:52:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607428328;
        bh=qXoKsH8IyPZo+6f6q7lrw5GuImluXxVlgfEO2PcZOVw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=krsumVr5tRDU3fH6ZpB53V1AmLtbtxreSPPOuOAx9dIYcCIkiUUht3+v9pldL8/o8
         WebKgq63uZz06ihygtxC51zFmp4JLCsmpZtOovFfrJDN3u+tIVp3jU+Jcm4jMyG9ET
         T2uyOVcGS3lHWvMyNEFpQOLrlxntT1tBrdziEmBM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B8Bq7h6092458
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 05:52:08 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 05:52:07 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 05:52:07 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B8Bq2YX040294;
        Tue, 8 Dec 2020 05:52:03 -0600
Subject: Re: [PATCH v3 04/20] dmaengine: ti: k3-udma-glue: Add function to get
 device pointer for DMA API
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <nm@ti.com>, <ssantosh@kernel.org>, <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>
References: <20201208090440.31792-1-peter.ujfalusi@ti.com>
 <20201208090440.31792-5-peter.ujfalusi@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <83289f9e-723e-4fa5-ec89-c69f0bcc5400@ti.com>
Date:   Tue, 8 Dec 2020 13:52:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201208090440.31792-5-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 08/12/2020 11:04, Peter Ujfalusi wrote:
> Glue layer users should use the device of the DMA for DMA mapping and
> allocations as it is the DMA which accesses to descriptors and buffers,
> not the clients
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
