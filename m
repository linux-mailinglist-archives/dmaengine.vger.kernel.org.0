Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B877436F3
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jun 2023 10:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjF3IWr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Jun 2023 04:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjF3IWp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Jun 2023 04:22:45 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AED129
        for <dmaengine@vger.kernel.org>; Fri, 30 Jun 2023 01:22:44 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76571dae5feso147745485a.1
        for <dmaengine@vger.kernel.org>; Fri, 30 Jun 2023 01:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688113363; x=1690705363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=24mW1z/BqCb5EBJHp3ULvIr3bZwApFxhHmnOyHEIWyI=;
        b=MvVFGuyKfZ4RfhcbEV9YmVNzMeIxc4lcl9UuH7lRzVqqYIW7z1hmetpngcE66TjiSp
         Dbd+W/JAvsyRkU1Lt4gibkJYQJwmnR5UExEuKeN2u+Gw6wtBMWnlZe9Ee9S76+3y3N5Q
         ZVdLeqtzOBMJ8pdPDIJcHy8+aJuNCq0IAzM4BOMXUh6a4CPmPkx4ZBrwdRyuIKx2q8UQ
         fqJGRrJ+T37eJ9YY0VDUYywTZ9HJXBos5x8HfTism8dGfUew0N8OD2V7Y78Udosc3T0D
         aFcn7HEjfNIsLkZok4Z2PUEW2RV1GSy2njui6Qw1whU6F436hR8HP0D7tIOU2xUQ4z33
         SNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688113363; x=1690705363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24mW1z/BqCb5EBJHp3ULvIr3bZwApFxhHmnOyHEIWyI=;
        b=gGO+wOAN67YOy6GWTLJTsBFYgNMGyb5KzYMWbfAh99tXjXSukIJw5zgiA6cM0uKU9B
         rta5bCgJI3G55P7Cs211/qKa01THqGwz4Pz7qOGv7OKm6UQPRoGNz3ZnUM5jj12M5VTC
         F2Vu31prVfE20qLqjlb20OhoNPg/TvFcr21c20KxsRzhv/Ap+K0CF62MtV+MbRqFljBD
         PMoScMxeYKj+U3Zrz/5xbT8Cu97PnkZR6meNqgPLHLFck/TQNJaUOcCucwb+/2DlmfRp
         3qNkIu9wtXq6p3RmGvXk+10SZRYm6/Q/5DASDQjg1pQL9V16+RAcVA9RwMRw9WSkXRRF
         pbIg==
X-Gm-Message-State: AC+VfDyAD6ER51sVfucpqqX0zVx15wcluNDzSwQHdK6BTTAkt9iVVsWl
        vbWcuXqbLdY0R+kHXAeGY79rsQ==
X-Google-Smtp-Source: ACHHUZ7M/I5tDg2Tx8uMTc+kdz6EifYof2eCpYo3fW6wNGsw+33eb+QabNrLyJHUsmo7kjyIkxcwkA==
X-Received: by 2002:a05:620a:8e0c:b0:767:2736:ecd4 with SMTP id re12-20020a05620a8e0c00b007672736ecd4mr1513344qkn.47.1688113363676;
        Fri, 30 Jun 2023 01:22:43 -0700 (PDT)
Received: from localhost.localdomain ([223.233.68.54])
        by smtp.gmail.com with ESMTPSA id a16-20020aa780d0000000b00666e2dac482sm9462967pfn.124.2023.06.30.01.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:22:43 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, agross@kernel.org,
        konrad.dybcio@linaro.org, conor+dt@kernel.org, robh+dt@kernel.org
Subject: [PATCH v9 0/2] dt-bindings: dma: Add support for SM6115 and QCM2290 SoCs
Date:   Fri, 30 Jun 2023 13:52:28 +0530
Message-Id: <20230630082230.2264698-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for SM6115 and QCM2290 SoCs in qcom,bam-dma bindings.
Also increase iommu maxItems for BAM DMA to 6 which is the number
required on sm8250 SoC.

This patchset is rebased on linux-next/master.

Changes since v8:
-----------------
- v8 can be viewed here: https://www.spinics.net/lists/linux-crypto/msg72349.html
- As rest of the patches from v8 have been applied to linux-next, dropped them from v9.
- Added dma list and maintainer in Cc again as the Cc list got messed up while
  sending out v8.

Changes since v7:
-----------------
- v7 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230519214813.2593271-1-bhupesh.sharma@linaro.org/
- Addressed Stephan's comment about RPM clocks for sm6115 crypto block in dtsi.
- Also fixed the iommu context ids for sm6115 crypto block in dtsi.

Changes since v6:
-----------------
- v6 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230405072836.1690248-1-bhupesh.sharma@linaro.org/
- Collected Acks, R-Bs and Tested-by for various patches.
- Addressed Konrad's comment about iommu sids for sm8150 and sm8250
  crypto node entries.
- Addressed Konrad's and Stephan's comments about adding RPM clock for
  crypto blocks on qcm2290 and sm6115.

Changes since v5:
-----------------
- v5 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230402100509.1154220-1-bhupesh.sharma@linaro.org/
- Collected Ack from Rob for [PATCH 01/11].
- Addressed Georgi's comment about interconnect cells in [PATCH 10/11].

Changes since v4:
-----------------
- v4 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230331164323.729093-1-bhupesh.sharma@linaro.org/
- Collected R-Bs from Konrad for a couple of patches sent in v4.
- Fixed incorrect email IDs for a couple of patches sent in v3, which I used for
  some patches created on a different work machine.
- No functional changes since v3.

Changes since v3:
-----------------
- v3 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230328092815.292665-1-bhupesh.sharma@linaro.org/
- Collected Acks from Krzysztof for a couple of patches sent in v3.
- Fixed review comments from Krzysztof regarding DMA binding document
  and also added a couple of new patches which are required to fix the
  'dtbs_check' errors highlighted after this fix.

Changes since v2:
-----------------
- v2 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230322114519.3412469-1-bhupesh.sharma@linaro.org/
- No functional change since v2. As the sdm845 patch from v1 was accepted in linux-next,
  dropped it from this version.

Changes since v1:
-----------------
- v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230321190118.3327360-1-bhupesh.sharma@linaro.org/
- Folded the BAM DMA dt-binding change.
  (sent earlier as: https://lore.kernel.org/linux-arm-msm/20230321184811.3325725-1-bhupesh.sharma@linaro.org/)
- Folded the QCE dt-binding change.
  (sent earlier as: https://lore.kernel.org/linux-arm-msm/20230320073816.3012198-1-bhupesh.sharma@linaro.org/)
- Folded Neil's SM8450 dts patch in this series.
- Addressed review comments from Rob, Stephan and Konrad.
- Collected Konrad's R-B for [PATCH 5/9].

Bhupesh Sharma (2):
  dt-bindings: dma: Add support for SM6115 and QCM2290 SoCs
  dt-bindings: dma: Increase iommu maxItems for BAM DMA

 .../devicetree/bindings/dma/qcom,bam-dma.yaml | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
2.38.1

