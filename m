Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEED827F9A3
	for <lists+dmaengine@lfdr.de>; Thu,  1 Oct 2020 08:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgJAGth (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Oct 2020 02:49:37 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56170 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAGth (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Oct 2020 02:49:37 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0916nUF5115339;
        Thu, 1 Oct 2020 01:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601534970;
        bh=f39Tm9PGnT5Kb0GT6JYUCDYVTa14cU//tN6YQOFFebI=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=st8gO3sABqq7+kizVNNxkEYJQ1ZwW9CLDWe175b9z+pqhimCnX55ne98V5ZjTCF0l
         quqRD5yjS7Revhh915W2t1J8+JHBK/KFl4aF+wkIaZjG30J9vna/ACNbNeBQ0KnzHx
         +TSuM33rmYMQGZgGcwvKFerY/CtLAh/GOPKdgdck=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0916nUkb050443;
        Thu, 1 Oct 2020 01:49:30 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 01:49:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 01:49:29 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0916nRJL084046;
        Thu, 1 Oct 2020 01:49:27 -0500
Subject: Re: [PATCH 09/18] dt-bindings: dma: ti: Add document for K3 BCDMA
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
 <20200930091412.8020-10-peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <9b0cea1e-c9c3-b38f-2bf1-1501133c16ae@ti.com>
Date:   Thu, 1 Oct 2020 09:49:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200930091412.8020-10-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

On 30/09/2020 12.14, Peter Ujfalusi wrote:
> New binding document for
> Texas Instruments K3 Block Copy DMA (BCDMA).
>=20
> BCDMA is introduced as part of AM64.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 183 ++++++++++++++++++=

>  1 file changed, 183 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-bcdma.y=
aml
>=20
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/D=
ocumentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> new file mode 100644
> index 000000000000..c84fb641738f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> @@ -0,0 +1,183 @@

=2E..

> +  compatible:
> +    enum:
> +      - ti,am64-dmss-bcdma

Would it be OK if I use ti,am64x-dmss-bcdma or should I stick with
am64-dmss-bcdma.
The TRM refers to the family as AM64x, but having the 'x' in the
compatible did not sounded right.

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

